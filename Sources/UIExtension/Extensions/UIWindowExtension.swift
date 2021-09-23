//
//  MainWindow.swift
//  Binders
//
//  Created by BENSALA on 10/04/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIWindow {
    public func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}

extension Array where Element == UIWindow {
    public func reload() {
        forEach { $0.reload() }
    }
}
#endif
