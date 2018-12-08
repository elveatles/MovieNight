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
    
    /// Get the system wide configuration information.
    /// Some elements of the API require some knowledge of this configuration data.
    case configuration(apiKey: String)
    /// Get the list of official genres for movies.
    case genreMovieList(apiKey: String)
    /// Get the list of popular people on TMDb. This list updates daily.
    case personPopular(apiKey: String, page: Int)
    /// Discover movies based on certain filters
    case discoverMovie(apiKey: String, page: Int, withGenres: Set<Genre>, withPeople: Set<Person>, primaryReleaseDateGte: Date?, primaryReleaseDateLte: Date?)
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
        case .configuration: return "\(rootPath)/configuration"
        case .genreMovieList: return "\(rootPath)/genre/movie/list"
        case .personPopular: return "\(rootPath)/person/popular"
        case .discoverMovie: return "\(rootPath)/discover/movie"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .configuration(let apiKey):
            return [URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey)]
        case .genreMovieList(let apiKey):
            return [URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey)]
        case .personPopular(let apiKey, let page):
            return [
                URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey),
                URLQueryItem(name: Tmdb.Keys.page, value: String(page))
            ]
        case .discoverMovie(let apiKey, let page, let withGenres, let withPeople, let primaryReleaseDateGte, let primaryReleaseDateLte):
            let genreIdsArray = withGenres.map { "\($0.id)" }
            let genreIds = genreIdsArray.joined(separator: "|")
            let peopleIdsArray = withPeople.map { "\($0.id)" }
            let peopleIds = peopleIdsArray.joined(separator: "|")
            
            var result = [
                URLQueryItem(name: Tmdb.Keys.apiKey, value: apiKey),
                URLQueryItem(name: Tmdb.Keys.page, value: String(page)),
                URLQueryItem(name: "with_genres", value: genreIds),
                URLQueryItem(name: "with_people", value: peopleIds)
            ]
            
            // Primary release date greater than or equal to
            if let releaseDate = primaryReleaseDateGte {
                let str = TmdbClient.dateFormatter.string(from: releaseDate)
                let queryItem = URLQueryItem(name: "primary_release_date.gte", value: str)
                result.append(queryItem)
            }
            
            // Primary release date less than or equal to
            if let releaseDate = primaryReleaseDateLte {
                let str = TmdbClient.dateFormatter.string(from: releaseDate)
                let queryItem = URLQueryItem(name: "primary_release_date.lte", value: str)
                result.append(queryItem)
            }
            
            return result
        }
    }
}
