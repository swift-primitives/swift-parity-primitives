// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-parity-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Parity Primitives",
            targets: ["Parity Primitives"]
        ),
        .library(
            name: "Parity Primitives Test Support",
            targets: ["Parity Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-pair-primitives"),
    ],
    targets: [
        .target(
            name: "Parity Primitives",
            dependencies: [
                .product(name: "Pair Primitives", package: "swift-pair-primitives"),
            ]
        ),
        .target(
            name: "Parity Primitives Test Support",
            dependencies: [
                "Parity Primitives",
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Parity Primitives Tests",
            dependencies: [
                "Parity Primitives",
                "Parity Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
