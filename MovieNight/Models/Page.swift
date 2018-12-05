//
//  Page.swift
//  MovieNight
//
//  Created by Erik Carlson on 11/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Generic page
struct Page<T: Codable>: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [T]
    
    init(page: Int, totalResults: Int, totalPages: Int, results: [T]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

/// Genres page
struct GenresPage: Codable {
    let genres: [Genre]
}
