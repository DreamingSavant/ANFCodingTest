//
//  ProductCardRepositoryTests.swift
//  ANF Code Test
//
//  Created by Rod on 9/25/25
//

import XCTest
@testable import ANF_Code_Test

final class ProductCardRepositoryTests: XCTestCase {
    var repository: ProductCardRepositoryContract!
    let serviceClient: ServiceClientAction = FakeServiceClient()
    override func setUp() {
        repository = ProductCardRepository(serviceClient: serviceClient)
    }

    override func tearDown() {
        repository = nil
    }
    
    func test_get_products_success() async {
        
       let products = try? await repository.getProducts(url: "exploreData")
        // state after calling getImages
        XCTAssertEqual(products?.count, 10)
    }
    
    func test_get_products_failure() async {
        
       let products = try? await repository.getProducts(url: "")
        // state after calling getImages
        XCTAssertNil(products)
    }
    
}
