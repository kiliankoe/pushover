// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Pushover",
    products: [
        .library(
            name: "Pushover",
            targets: ["Pushover"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Pushover",
            dependencies: []),
        .testTarget(
            name: "PushoverTests",
            dependencies: ["Pushover"]),
    ]
)
