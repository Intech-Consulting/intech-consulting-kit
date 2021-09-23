//
//  Bindable.swift
//  Extensions
//
//  Created by BENSALA on 02/05/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

import Foundation

public class Bindable<Value> {
    private var observations = [(Value) -> Bool]()
    private var lastValue: Value?

    public init(_ value: Value? = nil) {
        lastValue = value
    }
}

extension Bindable {
    public func addObservation<O: AnyObject>(for object: O, handler: @escaping (O, Value) -> Void) {
        // If we already have a value available, we'll give the
        // handler access to it directly.
        lastValue.map { handler(object, $0) }

        observations.append { [weak object] value in
            guard let object = object else {
                return false
            }
            handler(object, value)
            return true
        }
    }
}

extension Bindable {
    public func update(with value: Value) {
        lastValue = value
        observations = observations.filter { $0(value) }
    }
}

extension Bindable {
    public func bind<O: AnyObject>(to object: O,
                                   _ objectKeyPath: ReferenceWritableKeyPath<O, Value>) {
        addObservation(for: object) { object, observed in
            object[keyPath: objectKeyPath] = observed
        }
    }

    public func bind<O: AnyObject, T>(to object: O,
                                      _ objectKeyPath: ReferenceWritableKeyPath<O, T?>,
                                      transform: @escaping (Value) -> T?) {
        addObservation(for: object) { object, observed in
            object[keyPath: objectKeyPath] = transform(observed)
        }
    }

    public func bind<O: AnyObject, T>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        _ objectKeyPath: ReferenceWritableKeyPath<O, T>
    ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }

    public func bind<O: AnyObject, T>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        _ objectKeyPath: ReferenceWritableKeyPath<O, T?>
    ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }

    public func bind<O: AnyObject, T, R>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        _ objectKeyPath: ReferenceWritableKeyPath<O, R>,
        transform: @escaping (T) -> R
    ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = transform(value)
        }
    }

    public func bind<O: AnyObject, T, R>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        _ objectKeyPath: ReferenceWritableKeyPath<O, R?>,
        transform: @escaping (T) -> R?
    ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = transform(value)
        }
    }
}
