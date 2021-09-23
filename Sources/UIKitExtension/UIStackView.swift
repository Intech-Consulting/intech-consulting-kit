//
//  UIStackView.swift
//  Extensions
//
//  Created by BENSALA on 14/05/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIStackView {
    // MARK: - Methods

    public func removeAllArangedSubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
#endif
