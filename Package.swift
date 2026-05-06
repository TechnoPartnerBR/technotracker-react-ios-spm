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
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/2.1.3.1/TechnoTrackerReact.xcframework.zip",
            checksum: "646f9f69aa31ef58774cc0ab97c6b861301526791dd0641d3aa3f3d347ccbca1"
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
