//
//  DomainTests.swift
//  DomainTests
//
//  Created by Amine Bensalah on 23/06/2019.
//  Copyright © 2019 Amine Bensalah. All rights reserved.
//

@testable import LinkedListDataStructure
import XCTest

class SimpleListTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateNodeWithListOfValue() {
        let array = [1, 2, 3, 4]
        let node = LinkedNode(sequence: array)

        XCTAssertNotNil(node)
    }

    func testCreateNodeWithEmptyList() {
        let array: [Int] = []
        let node = LinkedNode(sequence: array)

        XCTAssertNil(node)
    }

    func testAddOneNode() {
        let node = LinkedNode(1)
        let next = LinkedNode(2)
        node.append(node: next)

        XCTAssertEqual(node.nextNode, next)
    }

    func testAddTwoNode() {
        let node = LinkedNode(1)
        let next = LinkedNode(2)
        let last = LinkedNode(3)
        node.append(node: next)
        node.append(node: last)

        XCTAssertEqual(next.nextNode, last)
    }

    func testAddRecursiveNode() {
        let node = LinkedNode(100)
        let next = LinkedNode(300)
        node.appendRecursive(node: next)

        XCTAssertEqual(node.nextNode, next)
    }

    func testAddAppendSequence() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        XCTAssertEqual(node.nextNode, next1)
        XCTAssertEqual(next1.nextNode, next2)
    }

    func testAddNodeWithValueOfNode() {
        let node = LinkedNode(10)
        let value = 11
        node.append(value: value)

        XCTAssertEqual(node.nextNode?.value, value)
    }

    func testCountNode() {
        let node = LinkedNode(100)
        let next = LinkedNode(300)
        node.appendRecursive(node: next)

        XCTAssertEqual(node.count, 2)
    }

    func testLastNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        XCTAssertEqual(node.last, next2)
    }

    func testHeadNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        XCTAssertEqual(node.head, node)
    }

    func testDescriptionNode() {
        let node = LinkedNode(100)
        let next = LinkedNode(300)
        node.appendRecursive(node: next)

        XCTAssertEqual(node.description, "100 -> 300 -> Empty")
    }

    func testRemoveLasetNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        let removeLast = node.removeLast()
        XCTAssertEqual(next2, removeLast)
    }

    func testRemoveLasetRecursiveNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        let removeLast = node.removeLastRecursive()
        XCTAssertEqual(next2, removeLast)
    }

    func testFindNodeWithIntegerIndexGetNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        let find = node.find(at: 2)
        XCTAssertEqual(next2, find)
    }

    func testFindNodeWithIntegerIndexGetNilNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        node.append(node: next1)

        let find = node.find(at: 2)
        XCTAssertNil(find)
    }

    func testFindIndexOfNodeWithValueGetNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        let index = node.index(of: "node one added by sequence")
        XCTAssertEqual(next1, node.find(at: index!))
    }

    func testFindIndexOfNodeWithValueGetNilNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        node.append(node: next1)

        let index = node.index(of: "node two added by sequence")
        XCTAssertNil(index)
    }

    func testFindNodeWithWhereClosureGetNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        let next2 = LinkedNode("node two added by sequence")
        node.append(elements: [next1, next2])

        let find = node.find(where: { $0 == "node one added by sequence" })
        XCTAssertEqual(next1, find)
    }

    func testFindNodeWithWhereClosureGetNilNode() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        node.append(node: next1)

        let find = node.find(where: { $0 == "" })
        XCTAssertNil(find)
    }

    func testForEach() {
        let node = LinkedNode("node")
        let next1 = LinkedNode("node one added by sequence")
        node.append(node: next1)

        for (index, nod) in node.enumerated() {
            XCTAssertEqual(nod, node.find(at: index))
        }
    }
}
