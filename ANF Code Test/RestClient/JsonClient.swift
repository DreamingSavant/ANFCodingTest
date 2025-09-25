//
//  JsonClient.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//
import Foundation


struct JsonClient: ServiceClientAction, JsonDecoder {
    func get(apiURL: String) async throws -> Data {
        guard let url = getMockDataURL(jsonName: apiURL) else {
            throw ServiceError.urlError
        }
        return try Data(contentsOf: url)
    }
    
    private func getMockDataURL(jsonName: String) -> URL? {
        guard let filepath = Bundle.main.path(forResource: jsonName, ofType: "json") else {
            return nil
        }
        let url = URL(fileURLWithPath: filepath)
        return url
    }
}

