//
//  Dependency.swift
//  DependencyInjection
//
//  Created by Amine Bensalah on 14/11/2019.
//

import Foundation

public protocol Dependency {
    /// The environement variable
    var environement: Environement { get }

    func set(environement: Environement)

    func create<T>(completion: (Dependency) -> T) -> T

    func create<T: DependencyServiceType>(_ type: T.Type) -> T

    @discardableResult
    func register<T>(_ type: T.Type, completion: (Dependency) -> T) -> T

    @discardableResult
    func register<T: DependencyServiceType>(_ type: T.Type) -> T

    @discardableResult
    func unregister<T>(_ type: T.Type) -> T?

    func resolve<T>(_ type: T.Type) -> T?

    func singleton<T>(_ type: T.Type, completion: (Dependency) -> T) -> T

    @discardableResult
    func singleton<T: DependencyServiceType>(_ type: T.Type) -> T

    func resolve<T>() throws -> T
}
