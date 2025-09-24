//
//  ABFResponse.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import Foundation

// MARK: - WelcomeElement
struct ANFResponse: Codable {
    let title, backgroundImage: String
    let content: [Content]?
    let promoMessage, topDescription, bottomDescription: String?
}

// MARK: - Content
struct Content: Codable {
    let target: String
    let title: String
    let elementType: String?
}
