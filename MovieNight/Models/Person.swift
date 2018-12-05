//
//  Person.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A person who works in movies
struct Person: Codable {
    let id: Int
    let name: String
    let profilePath: String
    let popularity: Float
    
    init(id: Int, name: String, profilePath: String, popularity: Float) {
        self.id = id
        self.name = name
        self.profilePath = profilePath
        self.popularity = popularity
    }
}
