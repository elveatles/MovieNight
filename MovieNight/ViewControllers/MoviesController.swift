//
//  MoviesController.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

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
    
    func fetchError(error: Error) {
        showAlert(title: "Failed to Download Movies", message: error.localizedDescription)
    }
}
