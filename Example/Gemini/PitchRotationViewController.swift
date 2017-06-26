//
//  PitchRotationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class PitchRotationViewController: UIViewController {

    @IBOutlet fileprivate weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.gemini
                .pitchRotationAnimation()
                .scale(0.7)
                .pitchEffect(rotationEffect)
        }
    }

    fileprivate let cellIdentifier = "MyCollectionViewCell"
    private(set) var rotationEffect: PitchRotationEffect = .pitchUp
    private(set) var scrollDirection: UICollectionViewScrollDirection = .horizontal

    static func make(with scrollDirection: UICollectionViewScrollDirection, effect: PitchRotationEffect) -> PitchRotationViewController {
        let storyboard = UIStoryboard(name: "PitchRotationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PitchRotationViewController") as! PitchRotationViewController
        viewController.rotationEffect  = effect
        viewController.scrollDirection = scrollDirection
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
            collectionView.collectionViewLayout = layout
        }
    }
}

//MARK: - UIScrollViewDelegate
extension PitchRotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.adaptGeminiAnimation()
    }
}

//MARK: - UICollectionViewDelegate
extension PitchRotationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.adaptGeminiAnimation(to: cell)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension PitchRotationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCollectionViewCell
        self.collectionView.adaptGeminiAnimation(to: cell)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PitchRotationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 30, height: collectionView.bounds.height - 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
