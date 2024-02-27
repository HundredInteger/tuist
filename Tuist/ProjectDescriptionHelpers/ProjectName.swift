//
//  ProjectName.swift
//  tuistTestManifests
//
//  Created by 백정수 on 2/28/24.
//

import ProjectDescription

public enum Module {
    case app
    
    case feature
    
    case core
    
    case shared
    
    case logger
}

extension Module {
    public var name: String {
        switch self {
        case .app:
            return "App"
            
        case .feature:
            return "Feature"
            
        case .core:
            return "Core"
            
        case .shared:
            return "Shared"
            
        case  .logger:
            return "Logger"
        }
    }
    
    public var path: ProjectDescription.Path {
        return .relativeToRoot("Projects/" + self.name)
    }
    
    public var project: TargetDependency {
        return .project(target: self.name, path: self.path)
    }
}

extension Module: CaseIterable { }



