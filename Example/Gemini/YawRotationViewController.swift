//
//  YawRotationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/26.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class YawRotationViewController: UIViewController {

    @IBOutlet weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor(red: 255 / 255, green: 208 / 255, blue: 72 / 255, alpha: 0.5)
            collectionView.gemini
                .yawRotationAnimation()
                .scale(0.7)
                .yawEffect(rotationEffect)
        }
    }

    fileprivate let cellIdentifier = "ImageCollectionViewCell"
    private(set) var rotationEffect: YawRotationEffect = .yawUp
    private(set) var scrollDirection: UICollectionViewScrollDirection = .horizontal

    fileprivate let images: [UIImage] = Resource.minions.images

    static func make(scrollDirection: UICollectionViewScrollDirection, effect: YawRotationEffect) -> YawRotationViewController {
        let storyboard = UIStoryboard(name: "YawRotationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "YawRotationViewController") as! YawRotationViewController
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:))))
    }

    func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

//MARK: - UIScrollViewDelegate
extension YawRotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

//MARK: - UICollectionViewDelegate
extension YawRotationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension YawRotationViewController: UICollectionViewDataSource {
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
extension YawRotationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 50, height: collectionView.bounds.width - 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellHeight: CGFloat = collectionView.bounds.width - 50
        return UIEdgeInsets(top: (collectionView.frame.height - cellHeight) / 2, left: 25, bottom: (collectionView.frame.height - cellHeight) / 2, right: 25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 80
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

