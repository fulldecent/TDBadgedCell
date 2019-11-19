// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "TDBadgedCell",
    products: [
        .library(
            name: "TDBadgedCell",
            targets: ["TDBadgedCell"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TDBadgedCell",
            dependencies: []
        ),
        .testTarget(
            name: "TDBadgedCellTests",
            dependencies: ["TDBadgedCell"]
        )
    ]
)
