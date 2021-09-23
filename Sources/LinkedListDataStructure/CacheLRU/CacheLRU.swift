// https://gist.github.com/MarcoSantarossa/e21599d028a9187e4f88e767f8d2acf0
// https://fr.wikipedia.org/wiki/Algorithmes_de_remplacement_des_lignes_de_cache
// https://marcosantadev.com/implement-cache-lru-swift/

/// CacheLRU class
public final class CacheLRU<Key: Hashable, Value> {
    private struct CachePayload {
        let key: Key
        let value: Value
    }

    private let capacity: Int
    private let list = DoublyLinkedList<CachePayload>()
    private var nodesDict = [Key: DoublyLinkedListNode<CachePayload>]()

    public init(capacity: Int) {
        self.capacity = capacity
    }

    public func setValue(_ value: Value, for key: Key) {
        let payload = CachePayload(key: key, value: value)

        if let node = nodesDict[key] {
            node.payload = payload
            list.moveHead(node)
        } else {
            let node = list.addHead(payload)
            nodesDict[key] = node
        }

        if list.count > capacity {
            let nodeRemoved = list.removeLast()
            if let key = nodeRemoved?.payload.key {
                nodesDict[key] = nil
            }
        }
    }

    func getValue(for key: Key) -> Value? {
        guard let node = nodesDict[key] else { return nil }
        list.moveHead(node)
        return node.payload.value
    }

    // swiftlint:disable empty_count
    deinit {
        nodesDict.removeAll()
        while list.count > 0 {
            list.removeLast()
        }
    }

    // swiftlint:enable empty_count
}
