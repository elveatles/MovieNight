//
//  ApiClient.swift
//  MovieNight
//
//  Created by Erik Carlson on 11/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Error thrown when ApiClient runs into a problem.
enum ApiError: Error {
    /// Request failed
    case requestFailed
    /// Invalid data fetched from request
    case invalidData
    /// Response code is not a success
    case responseUnsuccessful
    /// Very rare error in case ApiClient was deallocated before completionHandler is called
    case clientDeallocated
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request failed."
        case .invalidData: return "Invalid data."
        case .responseUnsuccessful: return "Response unsuccessful."
        case .clientDeallocated: return "Client deallocated."
        }
    }
}

/// Result of an ApiClient request
enum ApiResult<T> {
    /// Success case holds the result
    case success(result: T)
    /// Failure case holds the error
    case failure(error: Error)
}

/// General Rest API Client
protocol ApiClient: class {
    /// The session used to make requests
    var session: URLSession { get }
    /// Used to decode requested data to models
    var decoder: JSONDecoder { get }
    /// A fetch request that can be used for any endpoint that returns an object
    /// - Parameter request: The endpoint request to make.
    /// - Parameter completionHandler: The closure that is called with either a result or an error.
    func fetch<T: Decodable>(with request: URLRequest, completionHandler: @escaping (ApiResult<T>) -> Void)
}

extension ApiClient {
    func fetch<T: Decodable>(with request: URLRequest, completionHandler: @escaping (ApiResult<T>) -> Void) {
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                // Check for error
                if let error = error {
                    completionHandler(.failure(error: error))
                    return
                }
                
                // Cast URLResponse to HTTPURLResponse
                guard let httpResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(error: ApiError.requestFailed))
                    return
                }
                
                // Check response status code is success
                guard httpResponse.statusCode == 200 else {
                    completionHandler(.failure(error: ApiError.responseUnsuccessful))
                    return
                }
                
                // Check data exists
                guard let data = data else {
                    completionHandler(.failure(error: ApiError.invalidData))
                    return
                }
                
                // Get non-optional self (since self is weak)
                guard let s = self else {
                    completionHandler(.failure(error: ApiError.clientDeallocated))
                    return
                }
                
                // Try to decode response json to model
                do {
                    let model = try s.decoder.decode(T.self, from: data)
                    completionHandler(.success(result: model))
                } catch {
                    completionHandler(.failure(error: error))
                }
            }
        }
        task.resume()
    }
}
