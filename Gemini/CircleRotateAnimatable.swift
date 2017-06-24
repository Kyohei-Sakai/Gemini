//
//  CircleRotateAnimatable.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2017/06/12.
//
//

public protocol CircleRotateAnimatable {
    @discardableResult func radius(_ radius: CGFloat) -> CircleRotateAnimatable
}

extension GeminiAnimationModel: CircleRotateAnimatable {
    @discardableResult
    public func radius(_ radius: CGFloat) -> CircleRotateAnimatable {
        circleRadius = radius
        return self
    }
}
