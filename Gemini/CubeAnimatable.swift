//
//  CubeAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/12.
//
//

public protocol CubeAnimatable: EasingAnimatable, ShadowEffectable {
    @discardableResult func cubeDegree(_ degree: CGFloat) -> CubeAnimatable
}

extension GeminiAnimationModel: CubeAnimatable {
    @discardableResult
    public func cubeDegree(_ degree: CGFloat) -> CubeAnimatable {
        cubeDegree = degree
        return self
    }
}
