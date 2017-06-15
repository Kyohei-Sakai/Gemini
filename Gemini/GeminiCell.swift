//
//  GeminiCell.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

open class GeminiCell: UICollectionViewCell {
    override open func prepareForReuse() {
        super.prepareForReuse()
        adjustAnchorPoint()
    }

    open var shadowView: UIView? {
        return nil
    }
    
    open var debugLabel: UILabel? {
        return nil
    }
}
