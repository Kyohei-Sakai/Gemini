//
//  ScaleAnimatable.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2017/06/24.
//
//

import Foundation

public enum GeminScaleEffect {
    case scaleUp
    case scaleDown
}

public protocol ScaleAnimatable {
    @discardableResult func scale(_ scale: CGFloat) -> ScaleAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> ScaleAnimatable
}

extension GeminiAnimationModel: ScaleAnimatable {
    @discardableResult
    public func scale(_ scale: CGFloat) -> ScaleAnimatable {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> ScaleAnimatable {
        scaleEffect = effect
        return self
    }
}
