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
            branch: "main"
        )
    ],
    targets: [
        .binaryTarget(
            name: "TechnoTrackerReact",
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/2.1.2/TechnoTrackerReact.xcframework.zip",
            checksum: "911d47568b26d52a64d957a6bf02d2210e5b13af4248774ad0c59ae327537f78"
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
