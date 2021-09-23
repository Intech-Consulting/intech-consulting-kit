//
//  UISwitch+Combine.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import UIKit
import CombineExtension

public extension CombineExtensions where Base: UISwitch {
    var isOn: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.isOn)
            .eraseToAnyPublisher()
    }
}
