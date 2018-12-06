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
    var movies = [Movie]()
    
    private lazy var tableImagesDownloader: TableImagesDownloader = {
        return TableImagesDownloader(tableView: tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        downloadMovies()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        
        cell.detailTextLabel?.textColor = UIColor(white: 0.0, alpha: 0.4)
        // Set the year
        if let releaseDate = movie.releaseDate {
            let year = Calendar.current.component(.year, from: releaseDate)
            cell.detailTextLabel?.text = "\(year)"
        } else {
            cell.detailTextLabel?.text = "????"
        }
        
        // Set the image
        if let posterURL = movie.posterURL {
            downloadOrAssignImage(cell: cell, indexPath: indexPath, url: posterURL)
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// Download movies based on the users' combined preferences
    func downloadMovies() {
        TmdbClient.main.discoverMovie(page: 1, withGenres: moviePrefs.genres, withPeople: moviePrefs.people) { [weak self] (apiResult) in
            guard let s = self else {
                return
            }
            
            switch apiResult {
            case .success(let result):
                s.movies = result.results
                s.tableView.reloadData()
            case .failure(let error):
                s.showAlert(title: "Movie Download Failure", message: error.localizedDescription)
            }
        }
    }
    
    /**
     Download an image if it has not been downloaded, otherwise assign the image from the cache.
     
     - Parameter cell: The cell to assign the image to.
     - Parameter indexPath: The index path of the cell.
     - Parameter url: The url to download.
     */
    func downloadOrAssignImage(cell: UITableViewCell, indexPath: IndexPath, url: URL) {
        if let image = Cache.images[url] {
            cell.imageView?.image = image
        } else {
            // Assign different default image depending if the row is odd or even
            cell.imageView?.image = indexPath.row % 2 == 0 ? #imageLiteral(resourceName: "default") : #imageLiteral(resourceName: "default_odd")
            tableImagesDownloader.downloadImage(url: url, indexPath: indexPath)
        }
    }
}
