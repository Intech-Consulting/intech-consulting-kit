//
//  File.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 25/06/2019.
//

import Foundation

public protocol NameDescribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    public var typeName: String {
        String(describing: type(of: self))
    }

    public static var typeName: String {
        String(describing: self)
    }
}

extension NSObject: NameDescribable {}
