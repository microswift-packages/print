// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "serialPrint",
    products: [
        .library(
            name: "serialPrint",
            targets: ["serialPrint"]),
    ],
    dependencies: [
        .package(url: "https://github.com/microswift-packages/serial", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "serialPrint",
            dependencies: [],
            path: ".",
            sources: ["serialPrint.swift"]),
    ]
)
