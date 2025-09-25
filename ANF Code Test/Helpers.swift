//
//  Helpers.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//
import Foundation

extension URL {
    var upgradingToHTTPS: URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
                if components.scheme?.lowercased() == "http" { components.scheme = "https" }
                return components.url ?? self
    }
}
