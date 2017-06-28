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
        //
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        //
    }

    public func adaptGeminiAnimation() {
        guard let model = animationModel, model.isEnabled else { return }

        // TODO:  set scrollDirection in layout configure method
        guard let direction = (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection else { return }
        model.scrollDirection = GeminiScrollDirection(direction: direction)

        visibleCells
            .flatMap { $0 as? GeminiCell }
            .forEach { [weak self] cell in
                self?.adaptGeminiAnimation(to: cell)
            }
    }

    public func adaptGeminiAnimation(to cell: GeminiCell) {
        guard let model = animationModel, model.isEnabled else { return }

        // TODO:  set scrollDirection in layout configure method
        guard let direction = (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection else { return }
        model.scrollDirection = GeminiScrollDirection(direction: direction)

        let convertedFrame = convert(cell.frame, to: superview)
        let distance = model.distanceFromCenter(withParentFrame: frame, cellFrame: convertedFrame)

        guard model.needsCheckDistance == false &&
            abs(distance) <= model.visibleMaxDistance(withParentFrame: frame, cellFrame: convertedFrame) else {
            return
        }

        let ratio = model.distanceRatio(withParentFrame: frame, cellFrame: convertedFrame)
        cell.debugLabel?.text = String(format: "%.2f", distance)
        cell.shadowView?.alpha = model.shadowAlpha(withDistanceRatio: ratio)
        cell.adjustAnchorPoint(model.anchorPoint(withDistanceRatio: ratio))
        cell.layer.transform = model.transform(withParentFrame: frame, cellFrame: convertedFrame)
    }
}
