//
//  GenresController.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/3/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// A user selects genres they are interested in
class GenresController: UIViewController {
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectionCountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let genresDataSource = GenresDataSource()
    let numberOfGenresToSelect = 5
    var moviePrefs: MoviePrefs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = genresDataSource
        tableView.delegate = self
        
        genresDataSource.genres = Stub.genres
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func nextPrefs(_ sender: UIBarButtonItem) {
        // Get the root view controller to pass movie prefs data back to.
        // Force unwrapping because the app is broken if we can't get the root view controller
        // to pass data back to
        let vc = navigationController!.viewControllers.first as! ViewController
        // Get the genre objects from the user selection
        let indexPaths = tableView.indexPathsForSelectedRows ?? []
        moviePrefs.genres = indexPaths.map { self.genresDataSource.genres[$0.row] }
        // Update the root view controller
        vc.updateMoviePrefs(moviePrefs)
        navigationController?.popViewController(animated: true)
    }
    
    /// Update the UI based on the current user selection
    func updateForSelection() {
        let selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
        selectionCountLabel.text = "\(selectedCount) of \(numberOfGenresToSelect) selected"
        nextButton.isEnabled = selectedCount == numberOfGenresToSelect
    }
}


extension GenresController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Limit the number of cells that are allowed to be selected
        let selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
        guard selectedCount < numberOfGenresToSelect else {
            return nil
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateForSelection()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateForSelection()
    }
}
