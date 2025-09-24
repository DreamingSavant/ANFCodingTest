//
//  ANFNetwork.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidType
}

protocol ANFNetworking {
//    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
    func fetchImage(from url: URL) async throws -> UIImage
}

class ANFNetwork: ANFNetworking {
//    func fetchData<T>(from url: URL, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
//        URLSession.shared.dataTask(with: url) {
//            if let error = error
//        }
//    }

    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        }

    func fetchImage(from url: URL) async throws -> UIImage {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw NetworkError.invalidType
            }
            return image
        }
}
