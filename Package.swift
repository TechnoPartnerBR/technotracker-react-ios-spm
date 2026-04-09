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
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/2.1.0/TechnoTrackerReact.xcframework.zip",
            checksum: "3142107783e0bad9f47a362d31f52672990eaccf189998a0c6eb3893994dee97"
        ),
    ]
)
