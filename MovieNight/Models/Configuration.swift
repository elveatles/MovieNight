//
//  Configuration.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A TMDb API configuration
struct Configuration: Codable {
    let images: ImagesConfig
    
    /// Default configuration
    init() {
        self.images = ImagesConfig()
    }
}
