//
//  ProductCardViewModel.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25
//
import Foundation

enum ViewStates {
    case loading
    case load
    case error(message: String)
    case empty
}

final class ProductCardViewModel {
    private var repository: ProductCardRepositoryContract
    private(set) var products: [Product] = []

    @Published var viewStates: ViewStates = .empty
    
    init(repository: ProductCardRepositoryContract = ProductCardRepository()) {
        self.repository = repository
    }
}

extension ProductCardViewModel {
    func getProducts(url: String) async {
        viewStates = .loading
        do {
            products = try await  repository.getProducts(url: url)
            
            viewStates = .load
        } catch {
            viewStates = .error(message: error.localizedDescription)
        }
    }
    
    @MainActor
    func getImage(url: String) async throws -> Data {
        return try await repository.getProductImage(imageUrl: url)
    }
}
