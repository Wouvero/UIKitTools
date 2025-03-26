// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKitTools",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UIKitTools",
            targets: ["UIKitTools"]),
    ],
    targets: [
        .target(
            name: "UIKitTools"),

    ]
)
