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
    @discardableResult func maxShadowAlpha(_ alpha: CGFloat) -> Self
    @discardableResult func minShadowAlpha(_ alpha: CGFloat) -> Self
}

extension GeminiAnimationModel: ShadowEffectable {
    @discardableResult
    public func shadowEffect(_ effect: GeminiShadowEffect) -> Self {
        shadowEffect = effect
        return self
    }

    @discardableResult
    public func minShadowAlpha(_ alpha: CGFloat) -> Self {
        minShadowAlpha = alpha
        return self
    }

    @discardableResult
    public func maxShadowAlpha(_ alpha: CGFloat) -> Self {
        maxShadowAlpha = alpha
        return self
    }
}
