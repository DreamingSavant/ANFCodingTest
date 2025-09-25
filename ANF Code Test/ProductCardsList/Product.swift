//
//  Product.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

struct Product: Decodable {
    let title: String
    let backgroundImage: String
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
    let content: [Content]?
}

struct Content: Decodable {
    let title: String
    let target: String
}
