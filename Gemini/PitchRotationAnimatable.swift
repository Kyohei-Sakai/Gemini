//
//  PitchRotationAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/25.
//
//

public enum PitchRotationEffect {
    case pitchUp
    case pitchDown
    case sineWave
    case reverseSineWave
}

public protocol PitchRotationAnimatable {
    @discardableResult func degree(_ degree: CGFloat) -> PitchRotationAnimatable
    @discardableResult func pitchEffect(_ effect: PitchRotationEffect) -> PitchRotationAnimatable
    @discardableResult func scale(_ scale: CGFloat) -> PitchRotationAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> PitchRotationAnimatable
}

extension GeminiAnimationModel: PitchRotationAnimatable {
    @discardableResult
    public func degree(_ degree: CGFloat) -> PitchRotationAnimatable {
        pitchDegree = degree
        return self
    }

    @discardableResult
    public func pitchEffect(_ effect: PitchRotationEffect) -> PitchRotationAnimatable {
        pitchEffect = effect
        return self
    }

    @discardableResult
    public func scale(_ scale: CGFloat) -> PitchRotationAnimatable {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> PitchRotationAnimatable {
        scaleEffect = effect
        return self
    }
}
