import ProjectDescription

extension Project {
    
    static let bundleID = "io.tuistTest"
    static let iosVersion = "14.0"
    
    // 공통 설정을 재사용하기 위한 메소드
    private static func makeSettings(for name: String) -> Settings {
        return Settings.settings(
            base: ["USE_HEADERMAP": "YES"],
            configurations: [
                .debug(name: .debug, xcconfig: .relativeToRoot("Projects/App/Configurations/\(name)-DEV.xcconfig")),
                .release(name: .release, xcconfig: .relativeToRoot("Projects/App/Configurations/\(name)-RELEASE.xcconfig"))
            ]
        )
    }
    
    // 공통 스키마를 생성하기 위한 메소드
    private static func makeSchemes(for name: String) -> [Scheme] {
        return [
            Scheme(
                name: "\(bundleID)-Dev",
                shared: true,
                buildAction: BuildAction(targets: ["\(name)"]),
                runAction: .runAction(configuration: .debug),
                archiveAction: .archiveAction(configuration: .debug),
                profileAction: .profileAction(configuration: .debug),
                analyzeAction: .analyzeAction(configuration: .debug)
            ),
            Scheme(
                name: "\(bundleID)-Release",
                shared: true,
                buildAction: BuildAction(targets: ["\(name)"]),
                runAction: .runAction(configuration: .release),
                archiveAction: .archiveAction(configuration: .release),
                profileAction: .profileAction(configuration: .release),
                analyzeAction: .analyzeAction(configuration: .release)
            )
        ]
    }
    
    // 앱 프로젝트 생성을 위한 공통 메소드
    public static func app(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ProjectDescription.ResourceFileElements? = nil
    ) -> Project {
        return self.project(
            name: name,
            product: .app,
            bundleID: bundleID + ".\(name)",
            settings: makeSettings(for: name),
            schemes: makeSchemes(for: name),
            dependencies: dependencies,
            resources: resources,
            infoPlist: [
                "FirebaseAppDelegateProxyEnabled": false,
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": true,
                    "UISceneConfigurations": [
                        "UIWindowSceneSessionRoleApplication": [
                            [
                                "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
                                "UISceneConfigurationName": "Default Configuration"
                            ]
                        ]
                    ]
                ]
            ]
        )
    }
    
    // 모듈 프로젝트 생성을 위한 메소드
    public static func makeModule(
        name: String,
        product: Product,
        dependencies: [TargetDependency] = [],
        resources: ProjectDescription.ResourceFileElements? = nil
    ) -> Project {
        return self.project(
            name: name,
            product: product,
            bundleID: bundleID + ".\(name)",
            dependencies: dependencies,
            resources: resources
        )
    }
    
    // 공통 프로젝트 설정 메소드
    public static func project(
        name: String,
        product: Product,
        bundleID: String,
        settings: Settings? = nil,
        schemes: [Scheme] = [],
        dependencies: [TargetDependency] = [],
        resources: ProjectDescription.ResourceFileElements? = nil,
        infoPlist: [String: Plist.Value] = [:]
    ) -> Project {
        return Project(
            name: name,
            settings: settings ?? makeSettings(for: name),
            targets: [
                Target(
                    name: name,
                    platform: .iOS,
                    product: product,
                    bundleId: bundleID,
                    deploymentTarget: .iOS(targetVersion: iosVersion, devices: .iphone),
                    infoPlist: .extendingDefault(with: infoPlist),
                    sources: ["Sources/**"],
                    resources: resources,
                    dependencies: dependencies
                )
            ]
        )
    }
}

// 의존성 확장
public extension TargetDependency {
    static let alamofire: TargetDependency       = .external(name: "Alamofire")
    static let kingfisher: TargetDependency      = .external(name: "Kingfisher")
    static let toastSwift: TargetDependency      = .external(name: "Toast")
    static let floatingPanel: TargetDependency   = .external(name: "FloatingPanel")
    static let firebase: TargetDependency        = .external(name: "FirebaseMessaging")
}
