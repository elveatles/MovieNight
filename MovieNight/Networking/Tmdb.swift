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
        static let page = "page"
    }
    
    /// Get the list of official genres for movies.
    case genreMovieList(apiKey: String)
    /// Get the list of popular people on TMDb. This list updates daily.
    case personPopular(apiKey: String, page: Int)
    /// Discover movies based on certain filters
    case discoverMovie(apiKey: String, page: Int, withGenres: Set<Genre>, withPeople: Set<Person>)
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
        case .personPopular: return "\(rootPath)/person/popular"
        case .discoverMovie: return "\(rootPath)/discover/movie"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .genreMovieList(let apiKey):
            return [URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey)]
        case .personPopular(let apiKey, let page):
            return [
                URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey),
                URLQueryItem(name: Tmdb.Keys.page, value: String(page))
            ]
        case .discoverMovie(let apiKey, let page, let withGenres, let withPeople):
            let genreIdsArray = withGenres.map { "\($0.id)" }
            let genreIds = genreIdsArray.joined(separator: "|")
            let peopleIdsArray = withPeople.map { "\($0.id)" }
            let peopleIds = peopleIdsArray.joined(separator: "|")
            return [
                URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey),
                URLQueryItem(name: Tmdb.Keys.page, value: String(page)),
                URLQueryItem(name: "with_genres", value: genreIds),
                URLQueryItem(name: "with_people", value: peopleIds)
            ]
        }
    }
}
