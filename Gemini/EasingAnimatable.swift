//
//  EasingAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/07/01.
//
//

public protocol EasingAnimatable {
    @discardableResult func ease(_ easing: GeminiEasing) -> Self
}

extension GeminiAnimationModel: EasingAnimatable {
    @discardableResult
    public func ease(_ easing: GeminiEasing) -> Self {
        self.easing = easing
        return self
    }
}
