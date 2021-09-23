//
//  Inject.swift
//  DependencyInjection
//
//  Created by Amine Bensalah on 20/12/2019.
//

import Foundation

@propertyWrapper
public struct DependencyInjection<Value> {
    public init() {}

    public var wrappedValue: Value {
        resolve()
    }

    private func resolve() -> Value {
        do {
            return try DependencyInjector.dependencies.resolve()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
