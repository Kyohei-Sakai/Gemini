//
//  CircleRotateAnimatable.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2017/06/12.
//
//

public enum CircleRotateDirection {
    case `default`, reverse
}

public protocol CircleRotateAnimatable {
    @discardableResult func radius(_ radius: CGFloat) -> CircleRotateAnimatable
    @discardableResult func rotateDirection(_ direction: CircleRotateDirection) -> CircleRotateAnimatable
    @discardableResult func scale(_ scale: CGFloat) -> CircleRotateAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> CircleRotateAnimatable
}

extension GeminiAnimationModel: CircleRotateAnimatable {
    @discardableResult
    public func radius(_ radius: CGFloat) -> CircleRotateAnimatable {
        circleRadius = radius
        return self
    }

    @discardableResult
    public func rotateDirection(_ direction: CircleRotateDirection) -> CircleRotateAnimatable {
        rotateDirection = direction
        return self
    }

    @discardableResult
    public func scale(_ scale: CGFloat) -> CircleRotateAnimatable {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> CircleRotateAnimatable {
        scaleEffect = effect
        return self
    }
}
