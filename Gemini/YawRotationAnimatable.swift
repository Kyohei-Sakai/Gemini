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

public protocol YawRotationAnimatable {
    @discardableResult func degree(_ degree: CGFloat) -> YawRotationAnimatable
    @discardableResult func yawEffect(_ effect: YawRotationEffect) -> YawRotationAnimatable
    @discardableResult func scale(_ scale: CGFloat) -> YawRotationAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> YawRotationAnimatable
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

    @discardableResult
    public func scale(_ scale: CGFloat) -> YawRotationAnimatable {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> YawRotationAnimatable {
        scaleEffect = effect
        return self
    }
}
