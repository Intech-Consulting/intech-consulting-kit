//
//  UIStepper+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import UIKit
import CombineExtension

public extension CombineExtensions where Base: UIStepper {
    /// A publisher emitting value changes for this stepper.
    var value: AnyPublisher<Double, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.value)
                  .eraseToAnyPublisher()
    }
}
