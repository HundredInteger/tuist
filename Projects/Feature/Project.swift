import ProjectDescription
import ProjectDescriptionHelpers

let featureProject =  Project.makeModule(name: Module.feature.name,
                                         product: .framework,
                                                     dependencies:
                                                        [Module.core.project] +
                                         [Module.shared.project]
                                          )
