//
//  CircleRotationAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/12.
//
//

public enum CircleRotationDirection {
    case `default`, reverse
}

public protocol CircleRotationAnimatable {
    @discardableResult func radius(_ radius: CGFloat) -> CircleRotationAnimatable
    @discardableResult func rotateDirection(_ direction: CircleRotationDirection) -> CircleRotationAnimatable
    @discardableResult func scale(_ scale: CGFloat) -> CircleRotationAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> CircleRotationAnimatable
}

extension GeminiAnimationModel: CircleRotationAnimatable {
    @discardableResult
    public func radius(_ radius: CGFloat) -> CircleRotationAnimatable {
        circleRadius = radius
        return self
    }

    @discardableResult
    public func rotateDirection(_ direction: CircleRotationDirection) -> CircleRotationAnimatable {
        rotateDirection = direction
        return self
    }

    @discardableResult
    public func scale(_ scale: CGFloat) -> CircleRotationAnimatable {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> CircleRotationAnimatable {
        scaleEffect = effect
        return self
    }
}
