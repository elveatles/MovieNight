//
//  Endpoint.swift
//  MovieNight
//
//  Created by Erik Carlson on 11/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A type that provides URLRequests for defined API endpoints
protocol Endpoint {
    /// Returns the base URL for the API as a string
    var base: String { get }
    /// Returns the URL that all paths should start with as a string
    var rootPath: String { get }
    /// Returns the URL path for an endpoint as a string
    var path: String { get }
    /// Returns the URL parameters for a given endpoint as an array of URLQueryItem values
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    /// Returns an instance of URLComponents containing the base URL, path, and query items provided
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    /// Returns an instance of URLRequest encapsulating the endpoint URL.
    /// This URL is obtained through the `urlComponents` object.
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
