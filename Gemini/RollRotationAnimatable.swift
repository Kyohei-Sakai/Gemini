//
//  RollRotationAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/24.
//
//

public enum GeminiRollRotationEffect {
    case rollUp
    case rollDown
    case sineWave
    case reverseSineWave
}

public protocol RollRotationAnimatable {
    @discardableResult func degree(_ degree: CGFloat) -> RollRotationAnimatable
    @discardableResult func rollEffect(_ effect: GeminiRollRotationEffect) -> RollRotationAnimatable
    @discardableResult func scale(_ scale: CGFloat) -> RollRotationAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> RollRotationAnimatable
}

extension GeminiAnimationModel: RollRotationAnimatable {
    @discardableResult
    public func degree(_ degree: CGFloat) -> RollRotationAnimatable {
        rollDegree = degree
        return self
    }

    @discardableResult
    public func rollEffect(_ effect: GeminiRollRotationEffect) -> RollRotationAnimatable {
        rollEffect = effect
        return self
    }

    @discardableResult
    public func scale(_ scale: CGFloat) -> RollRotationAnimatable {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> RollRotationAnimatable {
        scaleEffect = effect
        return self
    }
}
