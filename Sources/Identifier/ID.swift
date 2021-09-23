//
//  File.swift
//  Identifier
//
//  Created by Amine Bensalah on 02/02/2020.
//

import Foundation

// public protocol ID: Codable, Equatable { }
//
// extension Int: ID {}
// extension String: ID {}
// extension UUID: ID {}
//
// public enum ModelError: Error {
//    case require(identifier: String, reason: String)
// }
//
// public protocol Model {
//
//    // MARK: ID
//
//    /// The associated Identifier type. Usually `Int` or `UUID`. Must conform to `ID`.
//    associatedtype ID: ID
//
//    /// Typealias for Swift `KeyPath` to an optional ID for this model.
//    typealias IDKey = WritableKeyPath<Self, ID?>
//
//    /// Swift `KeyPath` to this `Model`'s identifier.
//    static var idKey: IDKey { get }
// }
//
// extension Model {
//
//    /// Returns the model's ID, throwing an error if the model does not yet have an ID.
//    public func requireID() throws -> ID {
//        guard let id = self.modelID else {
//            throw ModelError.require(identifier: "idRequired", reason: "\(Self.self) does not have an identifier.")
//        }
//        return id
//    }
//
//    /// Access the identifier keyed by `idKey`.
//    public var modelID: ID? {
//        get {
//            let path = Self.idKey
//            return self[keyPath: path]
//        }
//        set {
//            let path = Self.idKey
//            self[keyPath: path] = newValue
//        }
//    }
// }
