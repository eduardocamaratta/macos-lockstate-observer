// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LockStateLogsServer",
    platforms: [
        .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
    ],
    targets: [
        .executableTarget(
            name: "lock-state-logs-server",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ],
            swiftSettings: swiftSettings
        )
    ],
    swiftLanguageModes: [.v5]
)

var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("DisableOutwardActorInference"),
        .enableExperimentalFeature("StrictConcurrency")
    ]
}
