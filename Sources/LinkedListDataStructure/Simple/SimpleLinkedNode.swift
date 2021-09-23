import Foundation

public class LinkedNode<T>: Sequence {
    public typealias Element = LinkedNode

    public var value: T
    public var nextNode: LinkedNode<T>?

    public init(_ value: T) {
        self.value = value
    }

    // swiftlint:disable empty_count
    public convenience init?(sequence: [T]) {
        guard sequence.count > 0 else { return nil }
        self.init(sequence[0])
        for index in 1 ..< sequence.count {
            append(value: sequence[index])
        }
    }

    // swiftlint:enable empty_count

    __consuming public func makeIterator() -> LinkedNodeIterator<T> {
        LinkedNodeIterator(current: self)
    }
}

public struct LinkedNodeIterator<T>: IteratorProtocol {
    public var current: LinkedNode<T>?

    public mutating func next() -> LinkedNode<T>? {
        if let node = current {
            current = node.nextNode
            return node
        }
        return current
    }
}

extension LinkedNode: Equatable where T: Equatable {
    public static func == (lhs: LinkedNode<T>, rhs: LinkedNode<T>) -> Bool {
        lhs.value == rhs.value && lhs.nextNode == rhs.nextNode
    }
}

extension LinkedNode {
    public func append(node: LinkedNode<T>) {
        var currentNode = self
        while currentNode.nextNode != nil {
            currentNode = currentNode.nextNode!
        }
        currentNode.nextNode = node
    }

    public func appendRecursive(node: LinkedNode<T>) {
        if let nextNode = nextNode {
            nextNode.appendRecursive(node: node)
        } else {
            nextNode = node
        }
    }

    public func append(elements: [LinkedNode<T>]) {
        for element in elements {
            appendRecursive(node: element)
        }
    }

    public func append(value: T) {
        appendRecursive(node: LinkedNode(value))
    }

    public func append(sequence: [T]) {
        for element in sequence {
            append(value: element)
        }
    }

    public var count: Int {
        var i = 1
        var currentNode = self
        while currentNode.nextNode != nil {
            i += 1
            currentNode = currentNode.nextNode!
        }
        return i
    }

    // swiftlint:disable empty_count
    public var isEmpty: Bool {
        count == 0
    }

    // swiftlint:enable empty_count
}

extension LinkedNode {
    public var last: LinkedNode<T> {
        if let nextNode = nextNode {
            return nextNode.last
        }
        return self
    }

    public var head: LinkedNode<T> {
        self
    }
}

extension LinkedNode: CustomStringConvertible {
    public var description: String {
        "\(value) -> \(nextNode != nil ? nextNode!.description : "Empty")"
    }
}

extension LinkedNode {
    public func removeLast() -> LinkedNode<T>? {
        var current = self
        while current.nextNode != nil {
            if current.nextNode!.nextNode == nil {
                break
            }
            current = current.nextNode!
        }
        let node = current.nextNode
        current.nextNode = nil
        return node
    }

    public func removeLastRecursive() -> LinkedNode<T>? {
        if nextNode!.nextNode != nil {
            return nextNode!.removeLastRecursive()
        }
        let node = nextNode
        nextNode = nil
        return node
    }
}

extension LinkedNode {
    public func find(at index: Int) -> LinkedNode<T>? {
        var i = 0
        var current = self
        while i != index {
            i += 1
            if current.nextNode != nil {
                current = current.nextNode!
            } else {
                return nil
            }
        }
        return current
    }
}

extension LinkedNode where T: Equatable {
    public func find(where predicate: (T) throws -> Bool) rethrows -> LinkedNode<T>? {
        var current: LinkedNode<T>? = self
        while current != nil {
            if try predicate(current!.value) {
                return current
            } else {
                current = current?.nextNode
            }
        }
        return current
    }

    public func index(of value: T) -> Int? {
        var current = self
        var i = 0
        while current.value != value {
            i += 1
            if let nextNode = current.nextNode {
                current = nextNode
            } else {
                return nil
            }
        }
        return i
    }
}
