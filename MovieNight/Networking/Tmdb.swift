//
//  Tmdb.swift
//  MovieNight
//
//  Created by Erik Carlson on 11/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// TMDb API Endpoints
enum Tmdb {
    /// queryItem keys
    struct Keys {
        static let apiKey = "api_key"
    }
    
    /// Get the list of official genres for movies.
    case genreMovieList(apiKey: String)
}

extension Tmdb: Endpoint {
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var rootPath: String {
        return "/3"
    }
    
    var path: String {
        switch self {
        case .genreMovieList: return "\(rootPath)/genre/movie/list"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .genreMovieList(let apiKey): return [URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey)]
        }
    }
}
