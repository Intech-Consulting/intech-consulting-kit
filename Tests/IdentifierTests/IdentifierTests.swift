@testable import Identifier
import XCTest

struct StringModel: Identifiable {
    let id: ID
}

struct IntModel: Identifiable {
    typealias RawIdentifier = Int
    let id: ID
}

struct Model: Identifiable, Codable {
    let id: ID
}

struct UUIDModel: Identifiable, Codable {
    typealias RawIdentifier = UUID
    let id: ID
}

final class IdentityTests: XCTestCase {
    func testStringBasedIdentifier() {
        let model = Model(id: "Hello, world!")
        XCTAssertEqual(model.id, "Hello, world!")
    }

    func testIntBasedIdentifier() {
        let model = IntModel(id: 7)
        XCTAssertEqual(model.id, 7)
    }

    func testCodableIdentifier() throws {
        let model = UUIDModel(id: Identifier(rawValue: UUID()))
        let data = try JSONEncoder().encode(model)
        let decoded = try JSONDecoder().decode(UUIDModel.self, from: data)
        XCTAssertEqual(model.id, decoded.id)
    }

    func testIdentifierEncodedAsSingleValue() throws {
        let model = Model(id: "I'm an ID")
        let data = try JSONEncoder().encode(model)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        XCTAssertEqual(json?["id"] as? String, "I'm an ID")
    }

    func testExpressingIdentifierUsingStringInterpolation() {
        let model = Model(id: "Hello, world!")
        XCTAssertEqual(model.id, "Hello, \("world!")")
    }

    func testIdentifierDescription() {
        let stringID: StringModel.ID = "An ID"
        let intID: IntModel.ID = 7

        XCTAssertEqual(stringID.description, "An ID")
        XCTAssertEqual(intID.description, "7")
    }
}
