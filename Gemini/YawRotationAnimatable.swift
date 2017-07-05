//
//  YawRotationAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/26.
//
//

public enum YawRotationEffect {
    case yawUp
    case yawDown
    case sineWave
    case reverseSineWave
}

public protocol YawRotationAnimatable: ScaleAnimatable, EasingAnimatable, UIAppearanceAnimatable {
    @discardableResult func degree(_ degree: CGFloat) -> YawRotationAnimatable
    @discardableResult func yawEffect(_ effect: YawRotationEffect) -> YawRotationAnimatable
}

extension GeminiAnimationModel: YawRotationAnimatable {
    @discardableResult
    public func degree(_ degree: CGFloat) -> YawRotationAnimatable {
        yawDegree = degree
        return self
    }

    @discardableResult
    public func yawEffect(_ effect: YawRotationEffect) -> YawRotationAnimatable {
        yawEffect = effect
        return self
    }
}
