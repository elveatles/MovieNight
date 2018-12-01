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
    /// API Key to use for endpoint authentication
    let apiKey: String
    let session: URLSession
    let decoder: JSONDecoder = {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
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
}
