import ProjectDescription
import ProjectDescriptionHelpers

let sharedProject = Project.makeModule(name: Module.shared.name,
                                        product: .framework,
                                         dependencies: [.kingfisher, .toastSwift, .floatingPanel],
                                resources: .default)

