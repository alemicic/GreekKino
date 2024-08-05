//
//  Extensions.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation

public typealias Model = Codable & Equatable & Hashable

public extension KeyedDecodingContainer {
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    func decodeIfPresent<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key, fallback: T) throws -> T where T : Decodable {
        return try self.decodeIfPresent(type, forKey: key) ?? fallback
    }
}
