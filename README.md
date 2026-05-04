# TechnoTracker React iOS

Distribuição via Swift Package Manager do **TechnoTrackerReact** — módulo nativo iOS para integração do TechnoTracker SDK em aplicativos React Native.

## Instalação

### Xcode

1. Em Xcode: **File → Add Package Dependencies...**
2. Cole a URL do repositório:
   ```
   https://github.com/TechnoPartnerBR/technotracker-react-ios-spm.git
   ```
3. Selecione a regra de versão desejada (ex: branch `main` ou tag `1.0.0`).

### Package.swift

Adicione ao seu `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/TechnoPartnerBR/technotracker-react-ios-spm.git",
        from: "1.0.0"
    )
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            .product(name: "TechnoTrackerReact", package: "technotracker-react-ios-spm")
        ]
    )
]
```

## Autenticação

O download do XCFramework requer credenciais Basic Auth (HTTP). Configure seu `~/.netrc`:

```
machine spm-sdk.technopartner.com.br
login <seu-usuario>
password <sua-senha>
```

Solicite credenciais à TechnoPartner.

## Quick Start

1. Adicione o pacote `TechnoTrackerReact` como dependência SPM no projeto.

2. No método `application(_:didFinishLaunchingWithOptions:)` da classe `AppDelegate`, adicione a seguinte linha:

> Ao inicializar, o módulo imprime sua versão no console: `[TechnoTrackerReact] version X.Y.Z`.

```swift
TechnoTrackerReact.shared.initialize()
```

3. Implemente a classe `TechnoTrackerModule` no app host e registre-a no `ReactPackage` da aplicação, conforme o passo a passo em [iOS Native Modules](https://reactnative.dev/docs/native-modules-ios).

4. Pronto! Agora é só utilizar as funções do módulo no *JavaScript* do aplicativo.

### Exemplo — AppDelegate

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    // ...

    /** TECHNOTRACKER integration: copy and paste this line into your own
     * AppDelegate application(_:didFinishLaunchingWithOptions:) method. */
    TechnoTrackerReact.shared.initialize()

    return true
}
```

### Implementação do TechnoTrackerModule

O app host deve criar dois arquivos para expor o módulo ao JavaScript:

**TechnoTrackerModule.swift**

```swift
import TechnoTrackerReact

@objc(TechnoTrackerModule)
class TechnoTrackerModule: NSObject {

    @objc(create:)
    func create(_ sdkToken: String) {
        TechnoTrackerReact.shared.initialize(token: sdkToken)
    }

    @objc(createAntennaId:)
    func createAntennaId(_ token: String) {
        Task { await TechnoTrackerReact.shared.registerAntennaID(seed: token) }
    }

    @objc func start() { TechnoTrackerReact.shared.start() }

    @objc func stop()  { TechnoTrackerReact.shared.stop()  }

    @objc(checkLocationPermission:rejecter:)
    func checkLocationPermission(_ resolve: @escaping RCTPromiseResolveBlock,
                                  rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let status = try await TechnoTrackerReact.shared.checkLocationPermission()
                resolve(status.bridgeValue)
            } catch {
                reject("E_PERMISSION", error.localizedDescription, error)
            }
        }
    }

    @objc(requestLocationPermission:rejecter:)
    func requestLocationPermission(_ resolve: @escaping RCTPromiseResolveBlock,
                                    rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let status = try await TechnoTrackerReact.shared.requestLocationPermission()
                resolve(status.bridgeValue)
            } catch {
                reject("E_PERMISSION", error.localizedDescription, error)
            }
        }
    }

    @objc(checkBluetoothPermission:rejecter:)
    func checkBluetoothPermission(_ resolve: @escaping RCTPromiseResolveBlock,
                                   rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let status = try await TechnoTrackerReact.shared.checkBluetoothPermission()
                resolve(status.bridgeValue)
            } catch {
                reject("E_PERMISSION", error.localizedDescription, error)
            }
        }
    }

    @objc(requestBluetoothPermission:rejecter:)
    func requestBluetoothPermission(_ resolve: @escaping RCTPromiseResolveBlock,
                                     rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let status = try await TechnoTrackerReact.shared.requestBluetoothPermission()
                resolve(status.bridgeValue)
            } catch {
                reject("E_PERMISSION", error.localizedDescription, error)
            }
        }
    }

    @objc static func requiresMainQueueSetup() -> Bool { false }
}

private extension PermissionStatus {
    var bridgeValue: String {
        switch self {
        case .granted:       return "granted"
        case .denied:        return "denied"
        case .restricted:    return "restricted"
        case .pendingAction: return "pendingAction"
        }
    }
}
```

**TechnoTrackerModule.m**

```objc
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(TechnoTrackerModule, NSObject)
RCT_EXTERN_METHOD(create:(NSString *)sdkToken)
RCT_EXTERN_METHOD(createAntennaId:(NSString *)token)
RCT_EXTERN_METHOD(start)
RCT_EXTERN_METHOD(stop)
RCT_EXTERN_METHOD(checkLocationPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(requestLocationPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(checkBluetoothPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(requestBluetoothPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
@end
```

## Pré-requisitos do SDK

### Background Modes

O TechnoTracker SDK requer que o app host declare os *background modes* necessários no `Info.plist`. No Xcode: **target → Signing & Capabilities → + Capability → Background Modes**.

| Mode | Chave `Info.plist` | Descrição |
|------|--------------------|-----------|
| Location updates | `location` | Mantém o processo vivo em background via `CLLocationManager`. Estratégia principal do SDK para executar scanning BLE contínuo. |
| Uses Bluetooth LE accessories | `bluetooth-central` | Scanning BLE em background com State Restoration. Permite que o iOS relance o app automaticamente ao detectar um dispositivo IoTracker conhecido. |

### Permissões de Privacidade

As seguintes chaves devem estar presentes no `Info.plist` do app host com uma descrição adequada ao contexto da aplicação:

| Chave | Obrigatória | Descrição |
|-------|-------------|-----------|
| `NSLocationAlwaysAndWhenInUseUsageDescription` | Sim | Exibida ao solicitar localização em modo *Always*. O SDK requer `authorizedAlways` para funcionar em background. |
| `NSLocationWhenInUseUsageDescription` | Sim | Exigida pelo iOS junto com a chave *Always* no fluxo de autorização de localização. |
| `NSBluetoothAlwaysUsageDescription` | Sim | Exibida ao inicializar o `CBCentralManager`. O acesso Bluetooth é necessário para a detecção de dispositivos IoTracker. |

### Autorização em tempo de execução

O app host é responsável por solicitar as permissões ao usuário. O módulo expõe métodos auxiliares para isso — veja a seção [Permissões](#permissões) do TechnoTrackerModule JavaScript.

- **Localização:** o SDK requer `authorizedAlways` para funcionar em background. *When In Use* não é suficiente.
- **Bluetooth:** autorização solicitada pelo sistema na primeira inicialização do `CBCentralManager`.

## TechnoTrackerModule (JavaScript)

Os métodos do módulo são acessados via JavaScript na aplicação ([testing native modules](https://reactnative.dev/docs/native-modules-ios#test-what-you-have-built)). Para inicializar o SDK pela primeira vez, com a chave de API fornecida pela TechnoPartner, invoque o método `create`:

```javascript
TechnoTrackerModule.create('sdk-api-token');
```

Uma vez inicializado, invoque `start` para que o SDK realize suas funções:

```javascript
TechnoTrackerModule.start();
```

**Nota**: Mesmo inicializado, o SDK permanecerá "dormente" até que a função `start` seja invocada.

Para parar a execução do SDK:

```javascript
TechnoTrackerModule.stop();
```

Por fim, registre um ID único para o SDK fornecendo uma *seed* única no contexto do aplicativo — por exemplo: e-mail/login do usuário, um ID interno do app, etc.

```javascript
TechnoTrackerModule.createAntennaId('seed-minha-claro');
```

### Permissões

O módulo expõe métodos auxiliares para verificar e solicitar as permissões necessárias. Eles retornam uma Promise com um dos valores: `"granted"`, `"denied"`, `"restricted"` ou `"pendingAction"`.

```javascript
// Verificar status atual sem exibir diálogo
const locationStatus = await TechnoTrackerModule.checkLocationPermission();
const bluetoothStatus = await TechnoTrackerModule.checkBluetoothPermission();

// Solicitar permissão (exibe diálogo do sistema se ainda não determinado)
const locationStatus = await TechnoTrackerModule.requestLocationPermission();
const bluetoothStatus = await TechnoTrackerModule.requestBluetoothPermission();
```

### Fluxo de inicialização

É recomendado que a inicialização do SDK, utilizando `TechnoTrackerModule.create` e `TechnoTrackerModule.start`, seja feita logo na inicialização do aplicativo, antes mesmo do login do usuário. Isso garante que o SDK irá executar durante todo o ciclo de vida da aplicação.

## Versões disponíveis

| Versão | Release | Notas |
|--------|---------|-------|
| 1.0.0  | 2026-04-07 | Versão inicial |
| 2.1.0  | 2026-04-09 | Scripts de build e upload para distribuição via SPM |
| 2.1.1  | 2026-04-10 | Minimum iOS deployment target lowered from 15.0 to 14.0 |
| 2.1.1.1 | 2026-04-30 | Fix missing IoTracker transitive dependency for SPM consumers |
| 2.1.2  | 2026-05-04 | Métodos de permissão de localização e Bluetooth via FinderManager |
