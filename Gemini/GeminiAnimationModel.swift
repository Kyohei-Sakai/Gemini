//
//  GeminiAnimationModel.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

enum GeminiAnimation {
    case cube
    case circle
    case custom
    case none
}

public enum ShadowEffect {
    case fadeIn
    case nextFadeIn
    case previousFadeIn
    case fadeOut
    case none
}

public protocol CubeAnimatable {
    func degree(_ degree: CGFloat) -> CubeAnimatable
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
    public func degree(_ degree: CGFloat) -> CubeAnimatable {
        cubeDegree = degree
        return self
    }

    @discardableResult
    public func shadowEffect(_ effect: ShadowEffect) -> CubeAnimatable {
        shadowEffect = effect
        return self
    }
}
public protocol CircleAnimatable {}
public protocol AnimationCustomizable {}

public protocol Gemini {
    func addCubeAnimation() -> CubeAnimatable
}

extension GeminiAnimationModel: Gemini {

    @discardableResult
    public func addCubeAnimation() -> CubeAnimatable {
        animation = .cube
        return self
    }
}

public final class GeminiAnimationModel {
    // Animation types
    fileprivate var animation: GeminiAnimation = .none
    fileprivate var shadowEffect: ShadowEffect = .none

    // Animation properties
    fileprivate var maxShadowAlpha: CGFloat = 1
    fileprivate var minShadowAlpha: CGFloat = 0

    fileprivate var cubeDegree: CGFloat = 90

    fileprivate lazy var transform3DIdentity: CATransform3D = {
        var identity = CATransform3DIdentity
        identity.m34 = 1 / 1000
        return identity
    }()

    var isEnabled: Bool {
        return animation != .none
    }

    func shadowAlpha(withDistanceRatio ratio: CGFloat) -> CGFloat {
        switch shadowEffect {
        case .fadeIn:
            return minShadowAlpha + abs(ratio) * maxShadowAlpha
        case .nextFadeIn:
            return ratio > 0 ? ratio * maxShadowAlpha : 0
        case .previousFadeIn:
            return ratio < 0 ? -ratio * maxShadowAlpha : 0
        case .fadeOut:
            return (1 - abs(ratio)) * maxShadowAlpha + minShadowAlpha
        case .none:
            return 0
        }
    }

    func transform(withDistanceRatio ratio: CGFloat) -> CATransform3D {
        switch animation {
        case .cube:
            let degree: CGFloat = ratio * -max(0, min(90, cubeDegree))
            let radian: CGFloat = degree * .pi / 180
            let rotateTransform    = CATransform3DRotate(transform3DIdentity, radian, 0, 1, 0)
            return rotateTransform
        default:
            //TODO:
            let degree: CGFloat = ratio * -90
            let radian: CGFloat = degree * .pi / 180
            let rotateTransform    = CATransform3DRotate(transform3DIdentity, radian, 0, 1, 0)
            return rotateTransform
        }
    }

    func anchorPoint(withDistanceRatio ratio: CGFloat) -> CGPoint {
        switch animation {
        case .cube:
            return ratio > 0 ? CGPoint(x: 0, y: 0.5) : CGPoint(x: 1, y: 0.5)//TODO: - vertical
        default:
            return CGPoint(x: 0, y: 0.5)
        }
    }
}


