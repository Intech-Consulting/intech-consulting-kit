import Combine
import UIKit
import CombineExtension

public extension CombineExtensions where Base: UIButton {
    var tap: AnyPublisher<Void, Never> {
        return Publishers
            .ControlEvent(control: base,
                          events: .touchUpInside)
            .eraseToAnyPublisher()
    }

    func control(events: Base.Event) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: base,
                                events: events)
            .eraseToAnyPublisher()
    }
}
