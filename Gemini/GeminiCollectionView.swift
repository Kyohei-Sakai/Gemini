//
//  GeminiCollectionView.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

public final class GeminiCollectionView: UICollectionView {
    public let gemini: Gemini = GeminiAnimationModel()

    private var animationModel: GeminiAnimationModel? {
        return gemini as? GeminiAnimationModel
    }

    // MARK: - Initialization -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    public func adaptGeminiAnimation() {
        guard let model = animationModel, model.isEnabled else { return }

        guard let direction = (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection else { return }
        
        model.scrollDirection = ScrollDirection(direction: direction)//convert extension
        let isVertical = direction == .vertical
        let middle = isVertical ? frame.height / 2 : frame.width / 2

        visibleCells
            .flatMap { $0 as? GeminiCell }
            .forEach { [weak self] cell in
                guard let me = self else { return }
                let convertedFrame = me.convert(cell.frame, to: me.superview)
                let distance = (isVertical ? convertedFrame.midY : convertedFrame.midX) - middle
                let distanceRatio = distance / (isVertical ? me.frame.height : me.frame.width)
                cell.debugLabel?.text = String(format: "%.2f", convertedFrame.origin.y)
                cell.shadowView?.alpha = model.shadowAlpha(withDistanceRatio: distanceRatio)
                cell.adjustAnchorPoint(model.anchorPoint(withDistanceRatio: distanceRatio))
                cell.layer.transform = model.transform(withDistanceRatio: distanceRatio)
            }
    }
}
