// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "TechnoTrackerReact",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TechnoTrackerReact",
            targets: ["TechnoTrackerReact", "TechnoTrackerReactDependencies"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/TechnoPartnerBR/technotracker-ios-spm",
            exact: "2.1.4"
        )
    ],
    targets: [
        .binaryTarget(
            name: "TechnoTrackerReact",
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/2.1.5/TechnoTrackerReact.xcframework.zip",
            checksum: "89dbfa0ac58b19588a1bbf19bb6b9ebface92add576e5ee9138cff7e36b79332"
        ),
        .target(
            name: "TechnoTrackerReactDependencies",
            dependencies: [
                .product(name: "IoTracker", package: "technotracker-ios-spm")
            ],
            path: "Sources/TechnoTrackerReactDependencies"
        ),
    ]
)
