//
//  Film.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 15.02.2021.
//

import Foundation

struct Film: Codable {
    let title, year, imdbID, type, poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
