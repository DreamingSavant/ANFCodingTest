//
//  ProductCardRepository.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import Foundation

protocol ProductCardRepositoryContract {
    func getProducts(url: String) async throws -> [Product]
    mutating func getProductImage(imageUrl: String) async throws -> Data
}

struct ProductCardRepository: ProductCardRepositoryContract, JsonDecoder {
    private let serviceClient: ServiceClientAction
    private var imageCache: [String: Data] = [:]
    init(serviceClient: ServiceClientAction = ServiceClient()) {
        self.serviceClient = serviceClient
    }
    
    func getProducts(url: String) async throws -> [Product] {
        let data = try await  serviceClient.get(apiURL: url)
        return try decode(type: [Product].self, data: data)
    }
    
    mutating func getProductImage(imageUrl: String) async throws -> Data {
        if let data = imageCache[imageUrl] {
            return data
        }
        let data = try await  serviceClient.get(apiURL: imageUrl)
        imageCache[imageUrl] = data
        return data
    }
}
