// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "print",
    products: [
        .library(
            name: "print",
            targets: ["print"]),
    ],
    dependencies: [
        .package(url: "https://github.com/microswift-packages/serial", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "print",
            dependencies: [],
            path: ".",
            sources: ["print.swift"]),
    ]
)
