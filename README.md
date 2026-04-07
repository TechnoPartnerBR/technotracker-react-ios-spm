# TechnoTracker React iOS SPM

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

## Versões disponíveis

| Versão | Release | Notas |
|--------|---------|-------|
| 1.0.0  | 2026-04-07 | Versão inicial |

## Documentação

Veja [technotracker-react](https://github.com/TechnoPartnerBR/technotracker-react) para documentação completa do módulo, API JavaScript e integração com React Native.
