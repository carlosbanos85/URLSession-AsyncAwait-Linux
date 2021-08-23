// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "URLSession-AsyncAwait-Linux",
    products: [
        .library(
            name: "URLSession-AsyncAwait-Linux",
            targets: ["URLSession-AsyncAwait-Linux"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "URLSession-AsyncAwait-Linux",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags(["-Xfronted", "-disable-availability-checking"])
            ]),
        .testTarget(
            name: "URLSession-AsyncAwait-LinuxTests",
            dependencies: ["URLSession-AsyncAwait-Linux"]),
    ]
)
