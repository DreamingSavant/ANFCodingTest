//
//  ANFExploreViewModel.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import Foundation
import UIKit

class ANFExploreViewModel {
    
    
    var exploreCards: [ANFResponse]?
    
    var aNFNetwork: ANFNetworking
    
    init(aNFNetwork: ANFNetworking = ANFNetwork()) {
        self.aNFNetwork = aNFNetwork
    }
    
    func getCards() async throws {
        guard let url = URL(string: ANFEUrls.mainURL) else {
            throw NetworkError.invalidType
        }
        var cards = try await aNFNetwork.fetch([ANFResponse].self, from: url)
        print("Here is the data", cards)
        exploreCards = cards
    }
    
    func fetchImage(url: URL) async -> UIImage? {
        return try? await aNFNetwork.fetchImage(from: url)
    }
}
