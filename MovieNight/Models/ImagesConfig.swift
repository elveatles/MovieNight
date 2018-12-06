//
//  ImagesConfig.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// TMDb image configuration which is a part of Configuration.
struct ImagesConfig: Codable {
    let secureBaseUrl: URL
    let posterSizes: [String]
    let profileSizes: [String]
    
    /// Default configuration
    init() {
        self.secureBaseUrl = URL(string: "https://image.tmdb.org/t/p/")!
        self.posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
        self.profileSizes = ["w45", "w185", "h632", "original"]
    }
}
