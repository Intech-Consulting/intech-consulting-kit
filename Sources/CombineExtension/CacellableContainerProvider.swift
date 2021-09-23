//
//  CacellableContainerProvider.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Foundation
import Combine

protocol CancellableContainerProvider {
    var cancellables: CancellableContainer { get }
}

extension NSObject: CancellableContainerProvider {

    private struct AssociatedKeys {
        static var DisposableKey = "CancellableBagKey"
    }

    public var cancellables: CancellableContainer {
        if let cancelBag = objc_getAssociatedObject(self, &NSObject.AssociatedKeys.DisposableKey) {
            return cancelBag as! CancellableContainer
        } else {
            let cancelBag = CancellableContainer()
            objc_setAssociatedObject(
                self,
                &NSObject.AssociatedKeys.DisposableKey,
                cancelBag,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            return cancelBag
        }
    }
}
