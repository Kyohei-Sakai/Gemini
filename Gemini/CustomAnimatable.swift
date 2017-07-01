//
//  CustomAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/15.
//
//

public protocol CustomAnimatable: EasingAnimatable, ShadowEffectable {
    @discardableResult func scale(x: CGFloat) -> CustomAnimatable
    @discardableResult func scale(y: CGFloat) -> CustomAnimatable
    @discardableResult func scale(z: CGFloat) -> CustomAnimatable
    @discardableResult func scale(x: CGFloat, y: CGFloat) -> CustomAnimatable
    @discardableResult func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> CustomAnimatable

    @discardableResult func rotationAngle(x: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(y: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(z: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(x: CGFloat, y: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    @discardableResult func translation(x: CGFloat) -> CustomAnimatable
    @discardableResult func translation(y: CGFloat) -> CustomAnimatable
    @discardableResult func translation(z: CGFloat) -> CustomAnimatable
    @discardableResult func translation(x: CGFloat, y: CGFloat) -> CustomAnimatable
    @discardableResult func translation(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    @discardableResult func anchorPoint(_ anchorPoint: CGPoint) -> CustomAnimatable
}

extension GeminiAnimationModel: CustomAnimatable {
    //Scale
    @discardableResult
    public func scale(x: CGFloat) -> CustomAnimatable {
        scaleStore.x = x
        return self
    }
    @discardableResult
    public func scale(y: CGFloat) -> CustomAnimatable {
        scaleStore.y = y
        return self
    }
    @discardableResult
    public func scale(z: CGFloat) -> CustomAnimatable {
        scaleStore.z = z
        return self
    }
    @discardableResult
    public func scale(x: CGFloat, y: CGFloat) -> CustomAnimatable {
        scaleStore.x = x
        scaleStore.y = y
        return self
    }
    @discardableResult
    public func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        scaleStore.x = x
        scaleStore.y = y
        scaleStore.z = z
        return self
    }
    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> CustomAnimatable {
        scaleEffect = effect
        return self
    }

    //Rotation
    @discardableResult
    public func rotationAngle(x: CGFloat) -> CustomAnimatable {
        rotationStore.x = x
        return self
    }
    @discardableResult
    public func rotationAngle(y: CGFloat) -> CustomAnimatable {
        rotationStore.y = y
        return self
    }
    @discardableResult
    public func rotationAngle(z: CGFloat) -> CustomAnimatable {
        rotationStore.z = z
        return self
    }
    @discardableResult
    public func rotationAngle(x: CGFloat, y: CGFloat) -> CustomAnimatable {
        rotationStore.x = x
        rotationStore.y = y
        return self
    }
    @discardableResult
    public func rotationAngle(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        rotationStore.x = x
        rotationStore.y = y
        rotationStore.z = z
        return self
    }

    //Translation
    @discardableResult
    public func translation(x: CGFloat) -> CustomAnimatable {
        translationStore.x = x
        return self
    }
    @discardableResult
    public func translation(y: CGFloat) -> CustomAnimatable {
        translationStore.y = y
        return self
    }
    @discardableResult
    public func translation(z: CGFloat) -> CustomAnimatable {
        translationStore.z = z
        return self
    }
    @discardableResult
    public func translation(x: CGFloat, y: CGFloat) -> CustomAnimatable {
        translationStore.x = x
        translationStore.y = y
        return self
    }
    @discardableResult
    public func translation(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        translationStore.x = x
        translationStore.y = y
        translationStore.z = z
        return self
    }

    @discardableResult
    public func anchorPoint(_ anchorPoint: CGPoint) -> CustomAnimatable {
        self.anchorPoint = anchorPoint
        return self
    }
}

// Custom animation properties
extension GeminiAnimationModel {
    struct ScaleStore {
        var x: CGFloat = 1
        var y: CGFloat = 1
        var z: CGFloat = 1
    }
    struct RotationStore {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var z: CGFloat = 0
    }
    struct TranslationStore {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var z: CGFloat = 0
    }
}
