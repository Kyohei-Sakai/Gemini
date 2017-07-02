//
//  ScaleAnimationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/28.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class ScaleAnimationViewController: UIViewController {

    @IBOutlet weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor(red: 240 / 255, green: 234 / 255, blue: 220 / 255, alpha: 1)
            collectionView.gemini
                .scaleAnimation()
                .scale(0.75)
                .scaleEffect(scaleEffect)
                .ease(.easeInExpo)
        }
    }

    fileprivate let cellIdentifier = "ImageCollectionViewCell"
    private(set) var scrollDirection: UICollectionViewScrollDirection = .horizontal
    private(set) var scaleEffect: GeminScaleEffect = .scaleUp

    fileprivate let images: [UIImage] = Resource.japan.images

    static func make(scrollDirection: UICollectionViewScrollDirection, scaleEffect: GeminScaleEffect) -> ScaleAnimationViewController {
        let storyboard = UIStoryboard(name: "ScaleAnimationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScaleAnimationViewController") as! ScaleAnimationViewController
        viewController.scrollDirection = scrollDirection
        viewController.scaleEffect = scaleEffect
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
            collectionView.collectionViewLayout = layout
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:))))
    }

    func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

//MARK: - UIScrollViewDelegate
extension ScaleAnimationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

//MARK: - UICollectionViewDelegate
extension ScaleAnimationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ScaleAnimationViewController: UICollectionViewDataSource {
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

//MARK: - UICollectionViewDelegateFlowLayout
extension ScaleAnimationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 80, height: collectionView.bounds.height - 400)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let isVertical = (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .vertical
        return UIEdgeInsets(top: isVertical ? 40 : 200, left: 40, bottom: isVertical ? 40 : 200, right: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
