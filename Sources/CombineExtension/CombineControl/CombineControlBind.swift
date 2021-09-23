//
//  CombineControlBind.swift
//  CombineExtension
//
//  Created by Amine Bensalah on 22/04/2020.
//

import Foundation
import Combine

extension Publisher where Output == Void, Failure == Never {
    public func observe(_ observer: @escaping () -> Void) -> AnyPublisher<Self, Never> {
        return Publishers.ControlCallback(self, callback: observer).eraseToAnyPublisher()
    }
}

extension Publishers {
    public struct ControlCallback<Callback: Publisher>: Publisher where Callback.Failure == Never {
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = SubscriptionImp(subscriber: subscriber, publisher: publisher, callback: callback)
            subscriber.receive(subscription: subscription)
        }

        public typealias Output = Callback
        public typealias Failure = Never

        private let publisher: Callback
        private let callback: () -> Void

        public init(_ publisher: Output, callback: @escaping () -> Void) {
            self.publisher = publisher
            self.callback = callback
        }
    }
}

extension Publishers.ControlCallback {
    private class SubscriptionImp<S: Subscriber, Output: Publisher>: Subscription where S.Input == Output, Output.Failure == Never {
        var subscriber: S?
        let callback: () -> Void
        var cancellable: AnyCancellable?

        init(subscriber: S?, publisher: Output, callback: @escaping () -> Void) {
            self.subscriber = subscriber
            self.callback = callback
            cancellable = publisher.sink { [weak self] _ in
                self?.run()
            }
        }

        func cancel() {
            subscriber = nil
            cancellable = nil
        }

        func request(_ demand: Subscribers.Demand) {

        }

        func run() {
            callback()
        }
    }
}
