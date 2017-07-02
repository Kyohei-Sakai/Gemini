//
//  ResourceModel.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/07/02.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

enum Resource {
    case building
    case food
    case japan
    case nature
    case people
    case minions
}

extension Resource {
    var images: [UIImage] {
        return imageNames.flatMap { UIImage(named: $0) }
    }

    var imageNames: [String] {
        switch self {
        case .building:
            return (1...10).map { "building\($0)" }
        case .food:
            return (1...10).map { "food\($0)" }
        case .japan:
            return (1...10).map { "japan\($0)" }
        case .nature:
            return (1...10).map { "nature\($0)" }
        case .people:
            return (1...10).map { "people\($0)" }
        case .minions:
            return (1...10).map { "minions\($0)" }
        }
    }
}
