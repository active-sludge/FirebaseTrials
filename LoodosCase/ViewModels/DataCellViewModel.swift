//
//  DataCellViewModel.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 16.02.2021.
//

import Foundation

struct DataCellViewModel {
    let title, year, poster: String?
    
    init(film: Film) {
        self.title = film.title
        self.year = film.year
        self.poster = film.poster
    }
    
}
