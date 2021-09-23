//
//  CombineExtensions.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Foundation

public protocol CombineExtensions {
    associatedtype Base
    var base: Base { get }
}

public struct Combine<Base>: CombineExtensions {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

public protocol CombineExtensionsProvider: AnyObject {}

extension CombineExtensionsProvider {
    /// Reactive extensions of `self`.
    public var publisher: Combine<Self> {
        Combine(self)
    }

    /// Reactive extensions of `Self`.
    public static var publisher: Combine<Self>.Type {
        Combine<Self>.self
    }
}

extension NSObject: CombineExtensionsProvider {}
