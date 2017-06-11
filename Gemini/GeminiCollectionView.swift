//
//  GeminiCollectionView.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

final class GeminiCollectionView: UICollectionView {
    public let gemini = GeminiAnimationModel()

    // MARK: - Initialization -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }

    public func adaptGeminiAnimation() {
        guard gemini.isEnabled else { return }

        let middleX = frame.width / 2
        visibleCells
            .flatMap { $0 as? GeminiCell }
            .forEach { [weak self] cell in
                guard let me = self else { return }
                let convertedFrame = me.convert(cell.frame, to: me.superview)
                let distance = convertedFrame.midX - middleX
                let distanceRatio = distance / me.frame.width
                cell.adjustAnchorPoint(me.gemini.anchorPoint(withDistanceRatio: distanceRatio))
                cell.layer.transform = me.gemini.transform(withDistanceRatio: distanceRatio)
            }
    }
}
