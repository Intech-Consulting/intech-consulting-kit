//
//  CollectionExtensions.swift
//  Extensions
//
//  Created by Amine Bensalah on 03/05/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        index >= 0 && index < count ? self[index] : nil
    }
}

extension Dictionary {
    public subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}

extension Set {
    public var array: [Element] {
        Array(self)
    }

    public subscript(safe index: Int) -> Element? {
        array[safe: index]
    }
}
