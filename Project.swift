import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains TuistTest App target and TuistTest unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// 프로젝트 설정
let project = Project(
    name: "tuistTest",
    organizationName: "io",
    packages: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        Target(
            name: "App",
            platform: .iOS,
            product: .app,
            bundleId: "com.yourorg.tuistTest",
            infoPlist: .extendingDefault(with: [
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1"
            ]),
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            dependencies: [
                .target(name: "Features"),
                .target(name: "Common"),
                .target(name: "Core")
            ]
        ),
        Target(
            name: "Features",
            platform: .iOS,
            product: .framework,
            bundleId: "com.yourorg.tuistTest.features",
            infoPlist: .default,
            sources: ["Features/Sources/**"],
            resources: ["Features/Resources/**"],
            dependencies: [
                .target(name: "Common"),
                .target(name: "Core"),
                .package(product: "Kingfisher")
            ]
        ),
        Target(
            name: "Common",
            platform: .iOS,
            product: .framework,
            bundleId: "com.yourorg.tuistTest.common",
            infoPlist: .default,
            sources: ["Common/Sources/**"],
            resources: ["Common/Resources/**"],
            dependencies: [
                .package(product: "Kingfisher")
            ]
        ),
        Target(
            name: "Core",
            platform: .iOS,
            product: .framework,
            bundleId: "com.yourorg.tuistTest.core",
            infoPlist: .default,
            sources: ["Core/Sources/**"],
            resources: ["Core/Resources/**"],
            dependencies: [
                .package(product: "Alamofire"),
                .package(product: "FirebaseAnalytics")
            ]
        )
    ]
)
