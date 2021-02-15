//
//  SearchResult.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 15.02.2021.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    let search: [Film]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
