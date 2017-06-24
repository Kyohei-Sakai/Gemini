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
}
