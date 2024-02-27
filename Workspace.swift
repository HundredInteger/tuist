//
//  Workspace.swift
//  tuistTestManifests
//
//  Created by 백정수 on 2/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "Projects",
                          projects: Module.allCases.map(\.path))
