// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "TechnoTrackerReact",
    platforms: [
        .iOS(.v15)
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
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/1.0.0/TechnoTrackerReact.xcframework.zip",
            checksum: "136bb3ab73c5fcee4facb1c71817450dddf953d26e3dc2917c9e638766b480b6"
        ),
    ]
)
