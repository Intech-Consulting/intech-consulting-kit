// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "intech-consulting-kit",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Cachable",
            targets: ["Cachable"]),
        .library(
            name: "CombineExtension",
            targets: ["CombineExtension"]),
        .library(
            name: "CombineUIKit",
            targets: ["CombineUIKit"]),
        .library(
            name: "Coordinator",
            targets: ["Coordinator"]),
        .library(
            name: "Core",
            targets: ["Core"]),
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]),
        .library(
            name: "Identifier",
            targets: ["Identifier"]),
        .library(
            name: "LinkedListDataStructure",
            targets: ["LinkedListDataStructure"]),
        .library(
            name: "PropertyWrapper",
            targets: ["PropertyWrapper"]),
        .library(
            name: "SwiftExtension",
            targets: ["SwiftExtension"]),
        .library(
            name: "UIKitExtension",
            targets: ["UIKitExtension"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Cachable",
            dependencies: []),
        .target(
            name: "CombineExtension",
            dependencies: []),
        .target(
            name: "CombineUIKit",
            dependencies: ["CombineExtension"]),
        .target(
            name: "Coordinator",
            dependencies: []),
        .target(
            name: "Core",
            dependencies: []),
        .target(
            name: "DependencyInjection",
            dependencies: []),
        .target(
            name: "Identifier",
            dependencies: []),
        .target(
            name: "LinkedListDataStructure",
            dependencies: []),
        .target(
            name: "PropertyWrapper",
            dependencies: ["SwiftExtension"]),
        .target(
            name: "SwiftExtension",
            dependencies: []),
        .target(name: "UIKitExtension",
                dependencies: ["SwiftExtension"]),
        .testTarget(
            name: "CachableTests",
            dependencies: ["Cachable"]),
        .testTarget(
            name: "CombineExtensionTests",
            dependencies: ["CombineExtension"]),
        .testTarget(
            name: "CombineUIKitTests",
            dependencies: ["CombineUIKit"]),
        .testTarget(
            name: "CoordinatorTests",
            dependencies: ["Coordinator"]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
        .testTarget(
            name: "DependencyInjectionTests",
            dependencies: ["DependencyInjection"]),
        .testTarget(
            name: "IdentifierTests",
            dependencies: ["Identifier"]),
        .testTarget(
            name: "LinkedListDataStructureTests",
            dependencies: ["LinkedListDataStructure"]),
        .testTarget(
            name: "PropertyWrapperTests",
            dependencies: ["PropertyWrapper"]),
        .testTarget(
            name: "SwiftExtensionTests",
            dependencies: ["SwiftExtension"]),
        .testTarget(
            name: "UIKitExtensionTests",
            dependencies: ["UIKitExtension"]),
    ]
)
