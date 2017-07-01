//
//  CubeAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/12.
//
//

import UIKit

public protocol CubeAnimatable: EasingAnimatable {
    @discardableResult func cubeDegree(_ degree: CGFloat) -> CubeAnimatable
    @discardableResult func maxShadowAlpha(_ alpha: CGFloat) -> CubeAnimatable
    @discardableResult func minShadowAlpha(_ alpha: CGFloat) -> CubeAnimatable
    @discardableResult func shadowEffect(_ effect: GeminiShadowEffect) -> CubeAnimatable
}

extension GeminiAnimationModel: CubeAnimatable {
    @discardableResult
    public func minShadowAlpha(_ alpha: CGFloat) -> CubeAnimatable {
        minShadowAlpha = alpha
        return self
    }

    @discardableResult
    public func maxShadowAlpha(_ alpha: CGFloat) -> CubeAnimatable {
        maxShadowAlpha = alpha
        return self
    }

    @discardableResult
    public func cubeDegree(_ degree: CGFloat) -> CubeAnimatable {
        cubeDegree = degree
        return self
    }

    @discardableResult
    public func shadowEffect(_ effect: GeminiShadowEffect) -> CubeAnimatable {
        shadowEffect = effect
        return self
    }
}
