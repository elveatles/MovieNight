//
//  Movie.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A movie from TMDb
struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: Date?
    let genreIds: [Int]
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate
        case genreIds
        case posterPath
    }
    
    /// All this just to set releaseDate to nil if the json value is an empty string
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        // releaseDate will be nil if the Date cannot be parsed.
        // Some release_date values from TMDb are empty strings.
        releaseDate = try? values.decode(Date.self, forKey: .releaseDate)
        genreIds = try values.decode([Int].self, forKey: .genreIds)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
    }
    
    init(id: Int, title: String, releaseDate: Date?, genreIds: [Int], posterPath: String?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.posterPath = posterPath
    }
}
