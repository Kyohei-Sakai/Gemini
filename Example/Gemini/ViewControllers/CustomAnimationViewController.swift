//
//  CustomAnimationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/07/01.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class CustomAnimationViewController: UIViewController {
    @IBOutlet weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.gemini
                .customAnimation()
                .translation(y: 50)
                .rotationAngle(y: 10)
                .ease(.easeOutExpo)
                .shadowEffect(.fadeIn)
                .maxShadowAlpha(0.3)
        }
    }

    fileprivate let cellIdentifier = "ImageCollectionViewCell"

    fileprivate let images: [UIImage] = Resource.building.images

    static func make() -> CustomAnimationViewController {
        let storyboard = UIStoryboard(name: "CustomAnimationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CustomAnimationViewController") as! CustomAnimationViewController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:))))

        let layout = UICollectionViewPagingFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width - 100, height: collectionView.bounds.height - 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }

    func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

//MARK: - UIScrollViewDelegate
extension CustomAnimationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

//MARK: - UICollectionViewDelegate
extension CustomAnimationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension CustomAnimationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(with: images[indexPath.row])
        self.collectionView.animateCell(cell)
        return cell
    }
}
