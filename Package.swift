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
            exact: "2.1.6"
        )
    ],
    targets: [
        .binaryTarget(
            name: "TechnoTrackerReact",
            url: "https://spm-sdk.technopartner.com.br/TechnoTrackerReact/2.1.7/TechnoTrackerReact.xcframework.zip",
            checksum: "328bb088a2774acb6cfabc71b1158d835550c25d116bb2b2af1c11df7eee5362"
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
