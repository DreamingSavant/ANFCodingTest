//
//  ProductCardViewModelTests.swift
//  ANF Code Test
//
//  Created by Rod on 9/25/25
//

import XCTest
@testable import ANF_Code_Test

final class ProductCardViewModelTests: XCTestCase {

    var viewModel: ProductCardViewModel!
    let repository: ProductCardRepositoryContract = FakeProductCardRepository()
    override func setUp() {
        viewModel = ProductCardViewModel(repository: repository)
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_get_products_success() async {
        
        // state before calling getImages
        XCTAssertEqual(viewModel.products.count, 0)

        await viewModel.getProducts(url: "mockUrl")
        
        // state after calling getImages
        XCTAssertEqual(viewModel.products.count, 1)
    }
    
    func test_get_products_failure() async {
                
        // state before calling getImages
        XCTAssertEqual(viewModel.products.count, 0)

        await viewModel.getProducts(url: "")
        
        // state after calling getImages
        XCTAssertEqual(viewModel.products.count, 0)
    }
    
    func test_get_product_image() async {
        
    
        let data = try? await viewModel.getImage(url: "mockImageURl")
        
        // state after calling getImage
        XCTAssertNotNil(data)
    }
    
}




