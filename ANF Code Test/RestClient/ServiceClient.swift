//
//  ServiceClient.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import UIKit

enum ServiceError: Error {
    case invalidResponse
    case urlError
    case serverNotFoundError
    case dataNotFound
}

protocol ServiceClientAction {
    func get(apiURL: String) async throws -> Data
}

struct ServiceClient {
    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension ServiceClient: ServiceClientAction {
    func get(apiURL: String) async throws -> Data {
        guard let url = URL(string: apiURL) else {
            throw ServiceError.urlError
        }
       let (data, _) = try await urlSession.data(from: url)
       return data
    }
}
