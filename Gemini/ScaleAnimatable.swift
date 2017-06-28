//
//  ScaleAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/24.
//
//

import Foundation

public enum GeminScaleEffect {
    case scaleUp
    case scaleDown
}

public protocol ScaleAnimatable {
    @discardableResult func scale(_ scale: CGFloat) -> Self
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> Self
}

extension GeminiAnimationModel: ScaleAnimatable {
    @discardableResult
    public func scale(_ scale: CGFloat) -> Self {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> Self {
        scaleEffect = effect
        return self
    }
}
