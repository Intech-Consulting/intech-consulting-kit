//
//  NSObjectProtocol+Bind.swift
//  Extensions
//
//  Created by Amine Bensalah on 28/05/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

import Foundation

extension NSObjectProtocol where Self: NSObject {
    public func bind<Value, Target>(
        _ sourceKeyPath: KeyPath<Self, Value>,
        to target: Target,
        at targetKeyPath: ReferenceWritableKeyPath<Target, Value>
    ) -> Disposable {
        observe(sourceKeyPath) { target[keyPath: targetKeyPath] = $0 }
    }

    public func bind<Value, Target: AnyObject>(
        _ sourceKeyPath: KeyPath<Self, Value>,
        to target: Target,
        at targetKeyPath: ReferenceWritableKeyPath<Target, Value>
    ) -> Disposable {
        observe(sourceKeyPath) { [weak target] in target?[keyPath: targetKeyPath] = $0 }
    }

    public func bindMap<Value, Target, NewValue>(
        _ sourceKeyPath: KeyPath<Self, Value>,
        to target: Target,
        at targetKeyPath: ReferenceWritableKeyPath<Target, NewValue>,
        transform: @escaping (Value) -> NewValue
    ) -> Disposable {
        observe(sourceKeyPath) { target[keyPath: targetKeyPath] = transform($0) }
    }

    public func bindMap<Value, Target: AnyObject, NewValue>(
        _ sourceKeyPath: KeyPath<Self, Value>,
        to target: Target,
        at targetKeyPath: ReferenceWritableKeyPath<Target, NewValue>,
        transform: @escaping (Value) -> NewValue
    ) -> Disposable {
        observe(sourceKeyPath) { [weak target] in target?[keyPath: targetKeyPath] = transform($0) }
    }

    @discardableResult
    public func bind(_ block: (Self) -> Swift.Void) -> Self {
        block(self)
        return self
    }

    @discardableResult
    public func bind<Value>(to object: Value, block: (Self, Value) -> Swift.Void) -> Self {
        block(self, object)
        return self
    }

    @discardableResult
    public func bind<Value1, Value2>(to object1: Value1, and object2: Value2, block: (Self, Value1, Value2) -> Swift.Void) -> Self {
        block(self, object1, object2)
        return self
    }
}

extension NSObjectProtocol where Self: NSObject {
    fileprivate func observer<Value>(_ keyPath: KeyPath<Self, Value>,
                                     onChange: @escaping (Value, Value?) -> Void) -> Disposable {
        let observation = observe(keyPath, options: [.initial, .new]) { _, change in
            guard let newValue = change.newValue else { return }
            onChange(newValue, change.oldValue)
        }
        return BlockDisposable { observation.invalidate() }
    }

    public func bindBidirection<Value: Equatable, Target: NSObject>(_ sourceKeyPath: ReferenceWritableKeyPath<Self, Value>,
                                                                    to target: Target,
                                                                    at targetKeyPath: ReferenceWritableKeyPath<Target, Value>) -> Disposable {
        let disposable1 = observer(sourceKeyPath) { [weak target] newValue, oldValue in
            guard let oldValue = oldValue, let targetValue = target?[keyPath: targetKeyPath], oldValue != targetValue else { return }
            target?[keyPath: targetKeyPath] = newValue
        }
        let disposable2 = target.observer(targetKeyPath) { [weak self] newValue, oldValue in
            guard let oldValue = oldValue, let sourceValue = self?.keyPathSelf[keyPath: sourceKeyPath], oldValue != sourceValue else { return }
            self?.keyPathSelf[keyPath: sourceKeyPath] = newValue
        }
        return CompositeDisposable([disposable1, disposable2])
    }
}
