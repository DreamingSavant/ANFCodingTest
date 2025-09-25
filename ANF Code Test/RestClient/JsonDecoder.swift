//
//  JsonDecoder.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//
import Foundation

protocol JsonDecoder {
    func decode<T: Decodable>(type: T.Type, data: Data) throws -> T
}

extension JsonDecoder {
    func decode<T>(type: T.Type, data: Data) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type.self, from: data)
    }
}
