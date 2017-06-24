//
//  CircleRotateViewController.swift
//  Gemini
//
//  Created by Shohei Yokoyama on 2017/06/20.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class CircleRotateViewController: UIViewController {

    static func make(with scrollDirection: UICollectionViewScrollDirection, rotateDirection: CircleRotateDirection) -> CircleRotateViewController {
        let storyboard = UIStoryboard(name: "CircleRotateViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CircleRotateViewController") as! CircleRotateViewController
        viewController.scrollDirection = scrollDirection
        viewController.rotateDirection = rotateDirection
        return viewController
    }

    fileprivate let cellIdentifier = "MyCollectionViewCell"

    private(set) var scrollDirection: UICollectionViewScrollDirection = .horizontal
    private(set) var rotateDirection: CircleRotateDirection = .default

    @IBOutlet fileprivate weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.gemini
                .circleRotateAnimation()
                .radius(450)
                .rotateDirection(rotateDirection)
                .scale(0.75)
        }
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
extension CircleRotateViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.adaptGeminiAnimation()
    }
}

//MARK: - UICollectionViewDelegate
extension CircleRotateViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.adaptGeminiAnimation(to: cell)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension CircleRotateViewController: UICollectionViewDataSource {
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
extension CircleRotateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
