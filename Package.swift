// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGardenCore",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "SwiftGardenCore",
            targets: ["SwiftGardenCore"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftGardenCore",
            dependencies: []),
        .testTarget(
            name: "SwiftGardenCoreTests",
            dependencies: ["SwiftGardenCore"]),
    ]
)
