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
    case circleRotation
    case rollRotation
    case pitchRotation
    case custom
    case none
}

//TODO: adapt all animation
public enum GeminiShadowEffect {
    case fadeIn
    case nextFadeIn
    case previousFadeIn
    case fadeOut
    case none
}

enum GeminiScrollDirection {
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
    @discardableResult func circleRotationAnimation() -> CircleRotationAnimatable
    @discardableResult func rollRotationAnimation() -> RollRotationAnimatable
    @discardableResult func pitchRotationAnimation() -> PitchRotationAnimatable
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
    public func circleRotationAnimation() -> CircleRotationAnimatable {
        animation = .circleRotation
        return self
    }

    @discardableResult
    public func rollRotationAnimation() -> RollRotationAnimatable {
        animation = .rollRotation
        return self
    }

    @discardableResult
    public func pitchRotationAnimation() -> PitchRotationAnimatable {
        animation = .pitchRotation
        return self
    }
}

public final class GeminiAnimationModel {
    // Animation types
    var animation: GeminiAnimation = .none

    // ShadowEffect types
    var shadowEffect: GeminiShadowEffect = .none

    // Shadow Alpha properties
    var maxShadowAlpha: CGFloat = 1
    var minShadowAlpha: CGFloat = 0

    // Cube animation property
    var cubeDegree: CGFloat = 90

    // CircleRotate animation property
    var circleRadius: CGFloat = 10
    var rotateDirection: CircleRotationDirection = .clockwise

    // Scale animation properties
    var scale: CGFloat = 1
    var scaleEffect: GeminScaleEffect = .scaleUp

    //Roll rotation animation properties
    var rollDegree: CGFloat = 90
    var rollEffect: GeminiRollRotationEffect = .rollUp

    //Pitch rotation animation properties
    var pitchDegree: CGFloat = 90
    var pitchEffect: PitchRotationEffect = .pitchUp

    // Custom animation properties
    lazy var scaleStore: ScaleStore = .init()
    lazy var rotationStore: RotationStore = .init()
    lazy var translationStore: TranslationStore = .init()

    var scrollDirection: GeminiScrollDirection = .vertical

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
        let ratio = distanceRatio(withParentFrame: parentFrame, cellFrame: cellFrame)

        switch animation {
        case .cube:
            let toDegree: CGFloat = max(0, min(90, cubeDegree))
            let degree: CGFloat
            switch scrollDirection {
            case .vertical:
                degree = ratio * toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 1, 0, 0)
            case .horizontal:
                degree = ratio * -toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 0, 1, 0)
            }

        case .circleRotation:
            let distance = distanceFromCenter(withParentFrame: parentFrame, cellFrame: cellFrame)
            let middle   = scrollDirection == .vertical ? parentFrame.midY : parentFrame.midX
            let maxCircleRadius = scrollDirection == .vertical ? middle + cellFrame.height / 2 : middle + cellFrame.width / 2
            let radius: CGFloat = max(maxCircleRadius, circleRadius)
            let _radian = asin(distance / radius)
            let radian  = rotateDirection == .clockwise ? -_radian : _radian

            let rotateTransform, translateTransform: CATransform3D
            switch scrollDirection {
            case .vertical:
                let _x = radius * (1 - cos(_radian))
                let x  = rotateDirection == .clockwise ? _x : -_x
                rotateTransform    = CATransform3DRotate(transform3DIdentity, radian, 0, 0, 1)
                translateTransform = CATransform3DTranslate(transform3DIdentity, x, 0, 0)
            case .horizontal:
                let _y = radius * (1 - cos(_radian))
                let y  = rotateDirection == .clockwise ? -_y : _y
                rotateTransform    = CATransform3DRotate(transform3DIdentity, radian, 0, 0, 1)
                translateTransform = CATransform3DTranslate(transform3DIdentity, 0, y, 0)
            }

            let scale = self.scale(withRatio: ratio)
            let scaleTransform = CATransform3DScale(transform3DIdentity, scale, scale, 0)
            return CATransform3DConcat(CATransform3DConcat(rotateTransform, translateTransform), scaleTransform)

        case .rollRotation:
            let toDegree: CGFloat = max(0, min(90, rollDegree))
            let _degree: CGFloat  = ratio * toDegree

            let degree: CGFloat
            switch rollEffect {
            case .rollUp :
                degree = _degree
            case .rollDown:
                degree = -_degree
            case .sineWave:
                degree = abs(_degree)
            case .reverseSineWave:
                degree = -abs(_degree)
            }
            
            let scale = self.scale(withRatio: ratio)
            let scaleTransform   = CATransform3DScale(transform3DIdentity, scale, scale, 0)
            let rotateTransform  = CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 0, 1, 0)
            return CATransform3DConcat(scaleTransform, rotateTransform)

        case .pitchRotation:
            let toDegree: CGFloat = max(0, min(90, pitchDegree))
            let _degree: CGFloat  = ratio * toDegree

            let degree: CGFloat
            switch pitchEffect {
            case .pitchUp :
                degree = -_degree
            case .pitchDown:
                degree = _degree
            case .sineWave:
                degree = -abs(_degree)
            case .reverseSineWave:
                degree = abs(_degree)
            }

            let scale = self.scale(withRatio: ratio)
            let scaleTransform   = CATransform3DScale(transform3DIdentity, scale, scale, 0)
            let rotateTransform  = CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 1, 0, 0)
            return CATransform3DConcat(scaleTransform, rotateTransform)

        default:
            return CATransform3DRotate(transform3DIdentity, 0, 0, 0, 0)
        }
    }

    func anchorPoint(withDistanceRatio ratio: CGFloat) -> CGPoint {
        switch animation {
        case .cube:
            switch scrollDirection {
            case .vertical   where ratio > 0: return CGPoint(x: 0.5, y: 0)
            case .vertical   where ratio < 0: return CGPoint(x: 0.5, y: 1)
            case .horizontal where ratio > 0: return CGPoint(x: 0, y: 0.5)
            case .horizontal where ratio < 0: return CGPoint(x: 1, y: 0.5)
            default: return CGPoint(x: 0.5, y: 0.5)
            }

        case .circleRotation:
            switch (rotateDirection, scrollDirection) {
            case (.clockwise, .horizontal):     return CGPoint(x: 0.5, y: 0)
            case (.anticlockwise, .horizontal): return CGPoint(x: 0.5, y: 1)
            case (.clockwise, .vertical):       return CGPoint(x: 1, y: 0.5)
            case (.anticlockwise, .vertical):   return CGPoint(x: 0, y: 0.5)
            }

        case .rollRotation:
            return CGPoint(x: 0.5, y: 0.5)

        case .pitchRotation:
            return CGPoint(x: 0.5, y: 0.5)

        default:
            return CGPoint(x: 0, y: 0.5)
        }
    }

    func distanceFromCenter(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        switch scrollDirection {
        case .vertical:   return cellFrame.midY - parentFrame.midY
        case .horizontal: return cellFrame.midX - parentFrame.midX
        }
    }

    func distanceRatio(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        let distance = distanceFromCenter(withParentFrame: parentFrame, cellFrame: cellFrame)
        switch scrollDirection {
        case .vertical:   return distance / (parentFrame.height / 2 + cellFrame.height / 2)
        case .horizontal: return distance / (parentFrame.width / 2 + cellFrame.width / 2)
        }
    }

    func visibleMaxDistance(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        switch scrollDirection {
        case .vertical:   return parentFrame.midY + cellFrame.height / 2
        case .horizontal: return parentFrame.midX + cellFrame.width / 2
        }
    }

    func scale(withRatio ratio: CGFloat) -> CGFloat {
        let scale: CGFloat = min(max(self.scale, 0), 1)
        switch scaleEffect {
        case .scaleUp:   return 1 - (1 - scale) * abs(ratio)
        case .scaleDown: return scale + (1 - scale) * abs(ratio)
        }
    }
}


