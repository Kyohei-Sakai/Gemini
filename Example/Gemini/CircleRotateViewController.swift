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

    static func make(with direction: UICollectionViewScrollDirection) -> CircleRotateViewController {
        let storyboard = UIStoryboard(name: "CircleRotateViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CircleRotateViewController") as! CircleRotateViewController
        viewController.direction = direction
        return viewController
    }
    
    fileprivate let cellIdentifier = "MyCollectionViewCell"

    var direction: UICollectionViewScrollDirection = .horizontal

    @IBOutlet fileprivate weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.gemini
                //.circleRotateAnimation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
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
