//
//  CubeAnimatable.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2017/06/12.
//
//

import UIKit

public protocol CubeAnimatable {
    func cubeDegree(_ degree: CGFloat) -> CubeAnimatable
    func maxShadowAlpha(_ alpha: CGFloat) -> CubeAnimatable
    func minShadowAlpha(_ alpha: CGFloat) -> CubeAnimatable
    func shadowEffect(_ effect: ShadowEffect) -> CubeAnimatable
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
    public func shadowEffect(_ effect: ShadowEffect) -> CubeAnimatable {
        shadowEffect = effect
        return self
    }
}
