//
//  Tmdb3Client.swift
//  MovieNight
//
//  Created by Erik Carlson on 11/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// TMDB API Client
class TmdbClient: ApiClient {
    static var main: TmdbClient = {
        let result = TmdbClient(apiKey: ApiKey.tmdb)
        return result
    }()
    
    static let dateFormat = "yyyy-MM-dd"
    /// The maximum page number allowed by the API
    static let maxPage = 1000
    
    /// API Key to use for endpoint authentication
    let apiKey: String
    let session: URLSession
    let decoder: JSONDecoder = {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        result.dateDecodingStrategy = .formatted(formatter)
        return result
    }()
    
    /**
     Initialize the client.
     
     - Parameter apiKey: API key to use for endpoint authentication.
     - Parameter configuration: Configuration to use for the session.
    */
    init(apiKey: String, configuration: URLSessionConfiguration = .default) {
        self.apiKey = apiKey
        self.session = URLSession(configuration: configuration)
    }
    
    /**
     Get the list of official genres for movies.
     
     - Parameter completionHandler: Closure that is called when the result is ready.
    */
    func genreMovieList(completionHandler: @escaping (ApiResult<GenresPage>) -> Void) {
        let endpoint = Tmdb.genreMovieList(apiKey: apiKey)
        let request = endpoint.request
        fetch(with: request, completionHandler: completionHandler)
    }
    
    /**
     Get the list of popular people on TMDb. This list updates daily.
     
     - Parameter page: Specify the page of results to query.
     - Parameter completionHandler: Called when the result is ready.
    */
    func personPopular(page: Int, completionHandler: @escaping (ApiResult<Page<Person>>) -> Void) {
        let endpoint = Tmdb.personPopular(apiKey: apiKey, page: page)
        let request = endpoint.request
        fetch(with: request, completionHandler: completionHandler)
    }
    
    /**
     Discover movies by different types of data like average rating, number of votes, genres and certifications.
     
     - Parameter page: Specify the page of results to query.
     - Parameter withGenres: Genres that you want to include in the results.
     - Parameter withPeople: Only include movies that have one of the people added as a either a actor or a crew member.
     - Parameter completionHandler: Called when the result is ready.
    */
    func discoverMovie(page: Int, withGenres: Set<Genre>, withPeople: Set<Person>, completionHandler: @escaping (ApiResult<Page<Movie>>) -> Void) {
        let endpoint = Tmdb.discoverMovie(apiKey: apiKey, page: page, withGenres: withGenres, withPeople: withPeople)
        let request = endpoint.request
        fetch(with: request, completionHandler: completionHandler)
    }
    
    /**
     Get the system wide configuration information. Some elements of the API require some knowledge of this configuration data.
     
     - Parameter completionHandler: Called when the result is ready.
    */
    func configuration(completionHandler: @escaping (ApiResult<Configuration>) -> Void) {
        let endpoint = Tmdb.configuration(apiKey: apiKey)
        let request = endpoint.request
        fetch(with: request, completionHandler: completionHandler)
    }
}
