import ProjectDescription
import ProjectDescriptionHelpers

let coreProject = Project.makeModule(name: Module.core.name,
                                     product: .framework,
                                     dependencies:
                                        [Module.logger.project] + [.alamofire, .kingfisher, .firebase]
)

