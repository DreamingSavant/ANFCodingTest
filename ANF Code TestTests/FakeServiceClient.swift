//
//  FakeServiceClient.swift
//  ANF Code Test
//
//  Created by Rod on 9/25/25
//

import Foundation
@testable import ANF_Code_Test

class FakeServiceClient: ServiceClientAction {
    func get(apiURL: String) async throws -> Data {
        if apiURL.isEmpty {
            throw ServiceError.urlError
        }
        return try await JsonClient().get(apiURL: apiURL)
    }
}

extension Product {
    static var products: [Product] {
        return [Product(title:"test",
                        backgroundImage: "test",
                        promoMessage: "test",
                        topDescription: "test",
                        bottomDescription: "test",
                        content: [Content(title:"",target: "")])
                       ]
    }
}
