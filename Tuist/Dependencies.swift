//
//  Dependencies.swift
//  tuistTestManifests
//
//  Created by 백정수 on 2/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
  swiftPackageManager: SwiftPackageManagerDependencies(
    [
        .alamofire,
        .kingfisher,
        .toastSwift,
        .floatingPanel,
        .firebase
    ],
    baseSettings: .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ]
    )
  ),
  platforms: [.iOS]
)

public extension Package {
    static let alamofire: Package       = .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .branch("master"))
    static let kingfisher: Package    = .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "5.15.6"))
    static let toastSwift: Package    = .remote(url: "https://github.com/scalessec/Toast-Swift.git", requirement: .branch("master"))
    static let floatingPanel: Package   = .remote(url: "https://github.com/scenee/FloatingPanel.git", requirement: .branch("master"))
    static let firebase: Package = .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "8.0"))
}

