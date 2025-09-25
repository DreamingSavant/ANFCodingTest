//
//  FakeProductRepository.swift
//  ANF Code Test
//
//  Created by Rod on 9/25/25
//

import Foundation
@testable import ANF_Code_Test

final class FakeProductCardRepository: ProductCardRepositoryContract {
    func getProducts(url: String) async throws -> [ANF_Code_Test.Product] {
        if url.isEmpty {
            throw ServiceError.urlError
        }
        return Product.products
    }
    
    func getProductImage(imageUrl: String) async throws -> Data {
        return Data()
    }
}
