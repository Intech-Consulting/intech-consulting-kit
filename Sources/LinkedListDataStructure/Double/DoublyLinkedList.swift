import Foundation

public typealias DoublyLinkedListNode<T> = DoublyLinkedList<T>.Node<T>

public final class DoublyLinkedList<T> {
    public final class Node<T> {
        public var payload: T
        public var previous: Node<T>?
        public var next: Node<T>?

        public init(payload: T) {
            self.payload = payload
        }
    }

    public private(set) var count: Int = 0
    private var head: Node<T>?
    private var tail: Node<T>?

    public func addHead(_ payload: T) -> Node<T> {
        let node = Node(payload: payload)
        defer {
            head = node
            count += 1
        }

        guard let head = head else {
            tail = node
            return node
        }

        head.previous = node
        node.previous = nil
        node.next = head

        return node
    }

    public func moveHead(_ node: Node<T>) {
        guard node !== head else { return }
        let previous = node.previous
        let next = node.next

        previous?.next = next
        next?.previous = previous

        node.next = head
        node.previous = nil

        if node === tail {
            tail = previous
        }

        head = node
    }

    @discardableResult
    public func removeLast() -> Node<T>? {
        guard let tail = self.tail else { return nil }

        let previous = tail.previous
        previous?.next = nil
        self.tail = previous

        if count == 1 {
            head = nil
        }

        count -= 1

        return tail
    }
}
