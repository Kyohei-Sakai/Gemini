//
//  PitchRotationAnimatable.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2017/06/24.
//
//

import Foundation

public enum RollRotationEffect {
    case pitchIn
    case pitchOut
}

public protocol RollRotationAnimatable {
    @discardableResult func degree(_ degree: CGFloat) -> RollRotationAnimatable
    @discardableResult func rotationEffect(_ effect: RollRotationEffect) -> RollRotationAnimatable
}
