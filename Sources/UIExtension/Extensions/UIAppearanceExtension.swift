//
//  File.swift
//  Extensions
//
//  Created by BENSALA on 25/04/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIAppearance {
    @discardableResult
    public func style(_ styleClosure: (Self) -> Swift.Void) -> Self {
        styleClosure(self)
        return self
    }
}
#endif
