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
            targets: ["TechnoTrackerReact"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "TechnoTrackerReact",
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/2.1.1/TechnoTrackerReact.xcframework.zip",
            checksum: "917f27111cdfb3a1b0df7cce44aafe94ca88d8115e036bf0c0f4eca6c41874f4"
        ),
    ]
)
