//
//  CustomAnimatable.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2017/06/15.
//
//

public protocol CustomAnimatable {
    @discardableResult func scale(x: CGFloat) -> CustomAnimatable
    @discardableResult func scale(y: CGFloat) -> CustomAnimatable
    @discardableResult func scale(z: CGFloat) -> CustomAnimatable
    @discardableResult func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    @discardableResult func rotationAngle(x: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(y: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(z: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    @discardableResult func translation(x: CGFloat) -> CustomAnimatable
    @discardableResult func translation(y: CGFloat) -> CustomAnimatable
    @discardableResult func translation(z: CGFloat) -> CustomAnimatable
    @discardableResult func translation(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable
}

extension GeminiAnimationModel: CustomAnimatable {
    //Scale
    @discardableResult
    public func scale(x: CGFloat) -> CustomAnimatable {
        scale.x = x
        return self
    }
    @discardableResult
    public func scale(y: CGFloat) -> CustomAnimatable {
        scale.y = y
        return self
    }
    @discardableResult
    public func scale(z: CGFloat) -> CustomAnimatable {
        scale.z = z
        return self
    }
    @discardableResult
    public func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        scale.x = x
        scale.y = y
        scale.z = z
        return self
    }

    //Rotation
    @discardableResult
    public func rotationAngle(x: CGFloat) -> CustomAnimatable {
        rotation.x = x
        return self
    }
    @discardableResult
    public func rotationAngle(y: CGFloat) -> CustomAnimatable {
        rotation.y = y
        return self
    }
    @discardableResult
    public func rotationAngle(z: CGFloat) -> CustomAnimatable {
        rotation.z = z
        return self
    }
    @discardableResult
    public func rotationAngle(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        rotation.x = x
        rotation.y = y
        rotation.z = z
        return self
    }

    //Translation
    @discardableResult
    public func translation(x: CGFloat) -> CustomAnimatable {
        translation.x = x
        return self
    }
    @discardableResult
    public func translation(y: CGFloat) -> CustomAnimatable {
        translation.y = y
        return self
    }
    @discardableResult
    public func translation(z: CGFloat) -> CustomAnimatable {
        translation.z = z
        return self
    }
    @discardableResult
    public func translation(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        translation.x = x
        translation.y = y
        translation.z = z
        return self
    }
}

// Custom animation properties
extension GeminiAnimationModel {
    struct Scale {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var z: CGFloat = 0
    }
    struct Rotation {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var z: CGFloat = 0
    }
    struct Translation {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var z: CGFloat = 0
    }
}
