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
    case circleRotate
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
    @discardableResult func circleRotateAnimation() -> CircleRotateAnimatable
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
    
    @discardableResult
    public func circleRotateAnimation() -> CircleRotateAnimatable {
        animation = .circleRotate
        return self
    }
}

public final class GeminiAnimationModel {
    // Animation types
    var animation: GeminiAnimation = .none

    // ShadowEffect types
    var shadowEffect: ShadowEffect = .none

    // Shadow Alpha properties
    var maxShadowAlpha: CGFloat = 1
    var minShadowAlpha: CGFloat = 0

    // Cube animation property
    var cubeDegree: CGFloat = 90

    // CircleRotate animation property
    var circleRadius: CGFloat = 10

    // Custom animation properties
    lazy var scale: Scale = .init()
    lazy var rotation: Rotation = .init()
    lazy var translation: Translation = .init()

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

    func transform(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CATransform3D {
        switch animation {
        case .cube:
            let ratio = distanceRatio(withParentFrame: parentFrame, cellFrame: cellFrame)
            let toDegree: CGFloat = max(0, min(90, cubeDegree))
            let degree: CGFloat
            if scrollDirection == .vertical {
                degree = ratio * toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 1, 0, 0)
            } else {
                degree = ratio * -toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 0, 1, 0)
            }
        case .circleRotate:
            let distance = distanceFromCenter(withParentFrame: parentFrame, cellFrame: cellFrame)
            let middle = scrollDirection == .vertical ? parentFrame.midY : parentFrame.midX
            let maxCircleRadius = scrollDirection == .vertical ? middle + cellFrame.height / 2 : middle + cellFrame.width / 2
            let radius: CGFloat = max(maxCircleRadius, circleRadius)
            let radian = asin(distance / radius)
            let y = radius * (1 - cos(radian))
            let rotateTransform = CATransform3DRotate(transform3DIdentity, radian, 0, 0, 1)
            let translateTransform = CATransform3DTranslate(transform3DIdentity, 0, y, 0)
            return CATransform3DConcat(rotateTransform, translateTransform)
        default:
            return CATransform3DRotate(transform3DIdentity, 0, 0, 0, 0)
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
        case .circleRotate:
            return CGPoint(x: 0.5, y: 1)
        default:
            return CGPoint(x: 0, y: 0.5)
        }
    }

    func distanceFromCenter(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        if scrollDirection == .vertical {
            return cellFrame.midY - parentFrame.midY
        } else {
            return cellFrame.midX - parentFrame.midX
        }
    }

    func distanceRatio(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        let distance = distanceFromCenter(withParentFrame: parentFrame, cellFrame: cellFrame)
        if scrollDirection == .vertical {
            return distance / (parentFrame.height / 2 + cellFrame.height / 2)
        } else {
            return distance / (parentFrame.width / 2 + cellFrame.width / 2)
        }
    }

    func visibleMaxDistance(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        if scrollDirection == .vertical {
            return parentFrame.midY + cellFrame.height / 2
        } else {
            return parentFrame.midX + cellFrame.width / 2
        }
    }
}


