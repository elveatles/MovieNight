//
//  MoviesDataSource.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/6/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Data source for movies
class MoviesDataSource: NSObject, UITableViewDataSource {
    // The combined movie preferences of two users. Used for fetching results.
    var moviePrefs: MoviePrefs
    // The table view this is for.
    let tableView: UITableView
    // Closure that is called when fetch errors occur.
    var fetchError: ((Error) -> Void)? {
        didSet {
            pagedDataSource.fetchError = fetchError
        }
    }
    /// Manages fetching pages for the tableView.
    private let pagedDataSource: PagedDataSource<Movie>
    /// Manages downloading images for the tableView.
    private let tableImagesDownloader: TableImagesDownloader
    
    /// Get the fetched entities
    var entities: [Movie] {
        return pagedDataSource.entities
    }
    
    /**
     Initializer.
     
     - Parameter tableView: The table view this is for.
     - Parameter moviePrefs: The combined movie preferences of two users. Used for fetching results.
    */
    init(tableView: UITableView, moviePrefs: MoviePrefs) {
        self.tableView = tableView
        self.moviePrefs = moviePrefs
        self.pagedDataSource = PagedDataSource(tableView: tableView)
        self.tableImagesDownloader = TableImagesDownloader(tableView: tableView)
        
        super.init()
        
        self.pagedDataSource.apiRequest = apiRequest
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagedDataSource.totalResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        // Default image is different depending if the row is even or odd.
        let defaultImage = indexPath.row % 2 == 0 ? #imageLiteral(resourceName: "default") : #imageLiteral(resourceName: "default_odd")
        
        if pagedDataSource.isLoadingCell(indexPath: indexPath) {
            cell.configure(with: nil)
            cell.imageView?.image = defaultImage
        } else {
            let movie = pagedDataSource.entities[indexPath.row]
            cell.configure(with: movie)
            if let imageView = cell.imageView {
                tableImagesDownloader.downloadOrAssignImage(imageView: imageView, indexPath: indexPath, url: movie.posterURL, defaultImage: defaultImage)
            }
        }
        
        return cell
    }
    
    /// Callback for pagedDataSource.apiRequest.
    /// Fills is parameters based on moviePrefs.
    func apiRequest(page: Int, completionHandler: @escaping (ApiResult<Page<Movie>>) -> Void) {
        TmdbClient.main.discoverMovie(
            page: page,
            withGenres: moviePrefs.genres,
            withPeople: moviePrefs.people,
            primaryReleaseDateGte: moviePrefs.releaseDateGte,
            primaryReleaseDateLte: moviePrefs.releaseDateLte,
            completionHandler: completionHandler)
    }
    
    /// Fetch more results
    func fetch() {
        pagedDataSource.fetch()
    }
}

extension MoviesDataSource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // Fetch more results if we scroll to cells that have not been loaded yet.
        if indexPaths.contains(where: pagedDataSource.isLoadingCell) {
            fetch()
        }
    }
}
