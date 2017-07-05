//
//  UIAppearanceAnimatable.swift
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

public protocol UIAppearanceAnimatable {
    @discardableResult func shadowEffect(_ effect: GeminiShadowEffect) -> Self
    @discardableResult func maxShadowAlpha(_ alpha: CGFloat) -> Self
    @discardableResult func minShadowAlpha(_ alpha: CGFloat) -> Self
    @discardableResult func alpha(_ alpha: CGFloat) -> Self
    @discardableResult func cornerRadius(_ radius: CGFloat) -> Self
    @discardableResult func backgroundColor(startColor: UIColor, endColor: UIColor) -> Self
}

extension GeminiAnimationModel: UIAppearanceAnimatable {
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

    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        cornerRadius = radius
        return self
    }

    @discardableResult
    public func backgroundColor(startColor: UIColor, endColor: UIColor) -> Self {
        startBackgroundColor = startColor
        endBackgroundColor = endColor
        return self
    }
}
