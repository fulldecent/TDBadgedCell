// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "TDBadgedCell",
    platforms: [.iOS(.v8)],
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
