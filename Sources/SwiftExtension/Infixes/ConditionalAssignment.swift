import Foundation

precedencegroup Comparison {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

infix operator ?= : Comparison

/// Assign value if not nil.
public func ?=<T>(left: inout T, right: T?) {
    // https://github.com/hyperoslo/Sugar
    guard let value = right else { return }
    left = value
}

/// Assign value if not nil.
public func ?=<T>(left: inout T?, right: T?) {
    // https://github.com/hyperoslo/Sugar
    guard let value = right else { return }
    left = value
}
