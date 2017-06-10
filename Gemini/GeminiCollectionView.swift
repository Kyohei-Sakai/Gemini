//
//  GeminiCollectionView.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

enum KeyPath: String {
    case contentOffset
}

final class GeminiCollectionView: UICollectionView {
    
    // MARK: - Initialization -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        observeContentOffset()
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        observeContentOffset()
        
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)

        if keyPath == KeyPath.contentOffset.rawValue {
            collectionViewDidScroll()
        }
    }
    
    private func observeContentOffset() {
        addObserver(self, forKeyPath: KeyPath.contentOffset.rawValue, options: .new, context: nil)
    }

    private func collectionViewDidScroll() {
        
    }
}
