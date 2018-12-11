//
//  MoviesController.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit
import Kingfisher

/// Where users can see the movie results based on their preferences
class MoviesController: UITableViewController {
    var moviePrefs: MoviePrefs!
    lazy var moviesDataSource: MoviesDataSource = {
        return MoviesDataSource(tableView: tableView, moviePrefs: moviePrefs)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.dataSource = moviesDataSource
        tableView.prefetchDataSource = moviesDataSource
        tableView.delegate = self
        
        moviesDataSource.fetchError = fetchError
        moviesDataSource.fetch()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Because UITableView reuses cells, if a cell is scrolled off screen while
        // its image is still downloading, the cell will be reused, but the old
        // image download will be used which is wrong.
        // By cancelling the image download when the cell scrolls off-screen,
        // this bug will be prevented.
        let movieCell = cell as! MovieCell
        movieCell.posterImageView.kf.cancelDownloadTask()
    }
    
    func fetchError(error: Error) {
        showAlert(title: "Failed to Download Movies", message: error.localizedDescription)
    }
}
