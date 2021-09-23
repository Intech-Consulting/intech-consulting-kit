//
//  UICollectionViewExtensions.swift
//  Extensions
//
//  Created by BENSALA on 13/05/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: "\(T.self)")
    }

    public func register<T: UICollectionViewCell>(_ cellClasses: [T.Type]) {
        cellClasses.forEach { register($0) }
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(withType _: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T
    }

    public func register<T: UICollectionReusableView>(_ viewHeaderFooterClass: T.Type) {
        register(viewHeaderFooterClass, forSupplementaryViewOfKind: "\(T.self)", withReuseIdentifier: "\(T.self)")
    }

    public func register<T: UICollectionReusableView>(_ viewHeaderFooterClasses: [T.Type]) {
        viewHeaderFooterClasses.forEach { register($0) }
    }

    public func dequeueReusableReusableView<T: UICollectionReusableView>(withType _: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableSupplementaryView(ofKind: "\(T.self)", withReuseIdentifier: "\(T.self)", for: indexPath) as? T
    }
}

extension UICollectionView {
    public func reloadData(completion: @escaping () -> Swift.Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
#endif
