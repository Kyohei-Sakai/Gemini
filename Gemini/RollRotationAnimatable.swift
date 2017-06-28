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

public protocol RollRotationAnimatable: ScaleAnimatable {
    @discardableResult func degree(_ degree: CGFloat) -> RollRotationAnimatable
    @discardableResult func rollEffect(_ effect: GeminiRollRotationEffect) -> RollRotationAnimatable
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
}
