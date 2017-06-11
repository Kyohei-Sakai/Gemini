//
//  GeminiAnimationModel.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

enum GeminiAnimation {
    case cube, circle, custom, none
}

public protocol CubeAnimatable {}

public protocol CircleAnimatable {}

public protocol AnimationCustomizable {}

protocol Gemini {
    func addCubeAnimation() -> CubeAnimatable
}

extension GeminiAnimationModel: Gemini {
    
    func addCubeAnimation() -> CubeAnimatable {
        animation = .cube
        return self
    }
}

final class GeminiAnimationModel {
    fileprivate var animation: GeminiAnimation = .none

    fileprivate lazy var transform3DIdentity: CATransform3D = {
        var identity = CATransform3DIdentity
        identity.m34 = 1 / 1000
        return identity
    }()

    var isEnabled: Bool {
        return animation != .none
    }

    func transform(withDistanceRatio ratio: CGFloat) -> CATransform3D {
        switch animation {
        case .cube:
            let degree: CGFloat = ratio * -90
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

extension GeminiAnimationModel: CubeAnimatable {

}
