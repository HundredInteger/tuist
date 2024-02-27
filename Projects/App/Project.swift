import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "TuistTest",
    dependencies: [Module.feature.project],
    resources: ResourceFileElements(resources: [.glob(pattern: "Resources/**")])
)

