//
//  UIBarButtonItem+Combine.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Foundation
import Combine
import CombineExtension
#if !os(macOS)
import UIKit.UIBarButtonItem

public extension CombineExtensions where Base: UIBarButtonItem {
    var tap: AnyPublisher<Void, Never> {
        Publishers.ControlTarget(control: base,
                                 addTargetAction: { control, target, action in
                                    control.target = target
                                    control.action = action
                                 },
                                 removeTargetAction: { control, _, _ in
                                    control?.target = nil
                                    control?.action = nil
                                 })
            .eraseToAnyPublisher()
    }
}
#endif
