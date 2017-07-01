//
//  ShadowEffectable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/07/01.
//
//

public enum GeminiShadowEffect {
    case fadeIn
    case nextFadeIn
    case previousFadeIn
    case fadeOut
    case none
}

public protocol ShadowEffectable {
    @discardableResult func shadowEffect(_ effect: GeminiShadowEffect) -> Self
}

extension GeminiAnimationModel: ShadowEffectable {
    @discardableResult
    public func shadowEffect(_ effect: GeminiShadowEffect) -> Self {
        shadowEffect = effect
        return self
    }
}
