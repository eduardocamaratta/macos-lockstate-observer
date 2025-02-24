// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "logs-server",
    platforms: [
        .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
    ],
    targets: [
        .executableTarget(
            name: "logs-server",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ],
            path: "Sources/App",
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "logs-server-tests",
            dependencies: [
                .target(name: "logs-server"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ],
    swiftLanguageModes: [.v5]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("DisableOutwardActorInference"),
    .enableExperimentalFeature("StrictConcurrency")
] }
