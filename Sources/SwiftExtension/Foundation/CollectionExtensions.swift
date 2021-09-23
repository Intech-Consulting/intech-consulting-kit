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

public extension Collection where Iterator.Element == (String, Any) {
    
    /// Converts collection of objects to JSON string
    var jsonString: String? {
        guard JSONSerialization.isValidJSONObject(self),
            let stringData = try? JSONSerialization.data(withJSONObject: self, options: [])
                else { return nil }
        
        return String(data: stringData, encoding: .utf8)
    }
}

public extension Sequence {

    /// Converts collection of objects to JSON string
    var jsonString: String? {
        guard let data = self as? [[String: Any]],
            let stringData = try? JSONSerialization.data(withJSONObject: data, options: [])
                else { return nil }
        
        return String(data: stringData, encoding: .utf8)
    }
    
    /**
     Returns the last that satisfies the predicate includeElement, or nil. Similar to `filter` but stops when last element is found.
     Thanks to [bigonotetaking](https://bigonotetaking.wordpress.com/2015/08/22/using-higher-order-methods-everywhere/)
     
     - parameter predicate: Predicate that the Element must satisfy.
     
     - returns: Last element that satisfies the predicate, or nil.
     */
    func last(_ pred: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for x in reversed() where pred(x) { return x }
        return nil
    }
    
    /**
     Returns true or false if the predicate returns all elements
     
     - parameter predicate: Predicate that all elements must satisfy
     
     - returns: Does the sequence contain all elements that satisfy the predicate
     */
    func all(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
}

