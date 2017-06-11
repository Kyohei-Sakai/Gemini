//
//  GeminiCell.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

public final class GeminiCell: UICollectionViewCell { }
extension GeminiCell: ShadowViewAnimatable {}

public protocol ShadowViewAnimatable { }

extension ShadowViewAnimatable {
    var shadowView: UIView? {
        return nil
    }
}
