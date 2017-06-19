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

enum ScrollDirection {
    case vertical
    case horizontal

    init(direction: UICollectionViewScrollDirection) {
        switch direction {
        case .horizontal:
            self = .horizontal
        case .vertical:
            self = .vertical
        }
    }
}

public protocol Gemini {
    var isEnabled: Bool { get }
    @discardableResult func cubeAnimation() -> CubeAnimatable
    @discardableResult func customAnimation() -> CustomAnimatable
}

extension GeminiAnimationModel: Gemini {

    public var isEnabled: Bool {
        return animation != .none
    }

    //Cube
    @discardableResult
    public func cubeAnimation() -> CubeAnimatable {
        animation = .cube
        return self
    }

    @discardableResult
    public func customAnimation() -> CustomAnimatable {
        animation = .custom
        return self
    }
}

public final class GeminiAnimationModel {
    // Animation types
    var animation: GeminiAnimation = .none
    var shadowEffect: ShadowEffect = .none

    // Animation properties
    var maxShadowAlpha: CGFloat = 1
    var minShadowAlpha: CGFloat = 0
    var cubeDegree: CGFloat = 90
    
    lazy var scale: Scale = Scale()
    lazy var rotation: Rotation = Rotation()
    lazy var translation: Translation = Translation()

    var scrollDirection: ScrollDirection = .vertical

    fileprivate lazy var transform3DIdentity: CATransform3D = {
        var identity = CATransform3DIdentity
        identity.m34 = 1 / 1000
        return identity
    }()

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

    func transform(withDistanceRatio ratio: CGFloat, cellSize: CGSize) -> CATransform3D {
        switch animation {
        case .cube:
            let toDegree: CGFloat = max(0, min(90, cubeDegree))
            let degree: CGFloat
            if scrollDirection == .vertical {
                degree = ratio * toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 1, 0, 0)
            } else {
                degree = ratio * -toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 0, 1, 0)
            }
        //case .custom: TODO: -
            
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
            if case .horizontal = scrollDirection {
                return ratio > 0 ? CGPoint(x: 0, y: 0.5) : CGPoint(x: 1, y: 0.5)
            } else {
               return ratio > 0 ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0.5, y: 1)
            }
        default:
            return CGPoint(x: 0, y: 0.5)
        }
    }
}


