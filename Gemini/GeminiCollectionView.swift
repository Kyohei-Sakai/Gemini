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

    override public var collectionViewLayout: UICollectionViewLayout {
        didSet {
            updateScrollDirection(with: collectionViewLayout)
        }
    }

    // MARK: - Initialization -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateScrollDirection(with: collectionViewLayout)
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        updateScrollDirection(with: layout)
    }

    override public func setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool) {
        super.setCollectionViewLayout(layout, animated: animated)
        updateScrollDirection(with: layout)
    }

    override public func setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool, completion: ((Bool) -> Swift.Void)? = nil) {
        super.setCollectionViewLayout(layout, animated: animated, completion: completion)
        updateScrollDirection(with: layout)
    }

    public func animateVisibleCells() {
        guard let model = animationModel, model.isEnabled else { return }

        visibleCells
            .flatMap { $0 as? GeminiCell }
            .forEach { [weak self] cell in
                self?.animateCell(cell)
            }
    }

    public func animateCell(_ cell: GeminiCell) {
        guard let model = animationModel, model.isEnabled else { return }

        let convertedFrame = convert(cell.frame, to: superview)
        let distance = model.distanceFromCenter(withParentFrame: frame, cellFrame: convertedFrame)

        if model.needsCheckDistance &&
            abs(distance) >= model.visibleMaxDistance(withParentFrame: frame, cellFrame: convertedFrame) {
            return
        }

        let ratio = model.distanceRatio(withParentFrame: frame, cellFrame: convertedFrame)

        cell.shadowView?.alpha = model.shadowAlpha(withDistanceRatio: ratio)
        cell.adjustAnchorPoint(model.anchorPoint(withDistanceRatio: ratio))
        cell.layer.transform = model.transform(withParentFrame: frame, cellFrame: convertedFrame)
    }

    private func updateScrollDirection(with layout: UICollectionViewLayout) {
        if let model = animationModel, let flowLayout = layout as? UICollectionViewFlowLayout  {
            model.scrollDirection = GeminiScrollDirection(direction: flowLayout.scrollDirection)
        }
    }
}
