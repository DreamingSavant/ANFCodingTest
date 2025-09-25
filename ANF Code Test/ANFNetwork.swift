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

enum ANFEUrls {
    static var mainURL = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css"
}

protocol ANFNetworking {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
    func fetchImage(from url: URL) async throws -> UIImage
}

class ANFNetwork: ANFNetworking {    
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
