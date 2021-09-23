//
//  UITextField+Combine.swift
//  Pods
//
//  Created by Amine Bensalah on 19/04/2020.
//

import Combine
import UIKit
import CombineExtension

public extension CombineExtensions where Base: UITextField {
    var text: AnyPublisher<String?, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.text)
            .eraseToAnyPublisher()
    }

    var attributedText: AnyPublisher<NSAttributedString?, Never> {
        Publishers.ControlProperty(control: base,
                                   events: .defaultValueEvents,
                                   keyPath: \.attributedText)
            .eraseToAnyPublisher()
    }

    var didEndOnExit: AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: base,
                                events: .editingDidEndOnExit)
            .eraseToAnyPublisher()
    }
}
