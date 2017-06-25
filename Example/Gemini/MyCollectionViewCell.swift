//
//  MyCollectionViewCell.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/11.
//  Copyright (c) 2017 shoheiyokoyama. All rights reserved.
//

import UIKit
import Gemini

final class MyCollectionViewCell: GeminiCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var blackShadowView: UIView! {
        didSet {
            blackShadowView.alpha = 0
            blackShadowView.backgroundColor = .black
        }
    }

    override var shadowView: UIView? {
        return blackShadowView
    }
    
    override var debugLabel: UILabel? {
        return label
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .red
    }

}
