// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dustman",
    platforms: [
        .macOS(.v11),
    ],
    products: [
        // Products define the executables and libraries produced by a package,
        // and make them visible to other packages.
        .executable(
            name: "Dustman",
            targets: ["Dustman"]
        ),
        .library(
            name: "Dustbin",
            targets: ["Dustbin"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "Dustman",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "Dustbin"),
            ]
        ),
        .target(
            name: "DustbinCore"
        ),
        .target(
            name: "DustbinDarwin",
            dependencies: [
                .target(name: "DustbinCore"),
            ]
        ),
        .target(
            name: "DustbinLinux",
            dependencies: [
                .target(name: "DustbinCore"),
            ]
        ),
        .target(
            name: "Dustbin",
            dependencies: [
                .target(name: "DustbinCore"),
                .target(name: "DustbinDarwin", condition: .when(platforms: [.macOS])),
                .target(name: "DustbinLinux", condition: .when(platforms: [.linux])),
            ]
        ),
        // TODO: Add tests for all the targets.
        .testTarget(
            name: "DustmanTests",
            dependencies: ["Dustman"]
        ),
    ]
)
