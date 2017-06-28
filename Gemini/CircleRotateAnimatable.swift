//
//  CircleRotationAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/12.
//
//

public enum CircleRotationDirection {
    case clockwise
    case anticlockwise
}

public protocol CircleRotationAnimatable: ScaleAnimatable {
    @discardableResult func radius(_ radius: CGFloat) -> CircleRotationAnimatable
    @discardableResult func rotateDirection(_ direction: CircleRotationDirection) -> CircleRotationAnimatable
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
}
