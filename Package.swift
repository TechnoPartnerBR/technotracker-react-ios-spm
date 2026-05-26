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
            exact: "2.1.5"
        )
    ],
    targets: [
        .binaryTarget(
            name: "TechnoTrackerReact",
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/2.1.6/TechnoTrackerReact.xcframework.zip",
            checksum: "3235cd08e450ee3bfc50c44432f3f6653c42bb5e7225bf6f963ffbba24e0a399"
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
