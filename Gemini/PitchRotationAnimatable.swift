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

public protocol PitchRotationAnimatable: ScaleAnimatable, EasingAnimatable {
    @discardableResult func degree(_ degree: CGFloat) -> PitchRotationAnimatable
    @discardableResult func pitchEffect(_ effect: PitchRotationEffect) -> PitchRotationAnimatable
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
}
