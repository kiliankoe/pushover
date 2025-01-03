// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "Pushover",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .macCatalyst(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
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
