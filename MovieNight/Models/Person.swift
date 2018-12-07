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
    let profilePath: String?
    let popularity: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath
        case popularity
    }
    
    /// Get the full URL for the profile image by combining configuration base URL and profilePath
    var profileURL: URL? {
        guard let pPath = profilePath else {
            return nil
        }
        
        let imagesConfig = Cache.configuration.images
        let size = imagesConfig.profileSizes.first ?? "w45"
        var result = imagesConfig.secureBaseUrl.appendingPathComponent(size)
        result = result.appendingPathComponent(pPath)
        return result
    }
    
    init(id: Int, name: String, profilePath: String?, popularity: Float) {
        self.id = id
        self.name = name
        self.profilePath = profilePath
        self.popularity = popularity
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
}
