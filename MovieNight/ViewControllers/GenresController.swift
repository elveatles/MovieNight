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
    
    private let genresDataSource = GenresDataSource()
    private lazy var selectionDelegate: TableMultiSelectionDelegate = {
        return TableMultiSelectionDelegate(selectionCountLabel: selectionCountLabel, nextButton: nextButton)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = genresDataSource
        tableView.delegate = selectionDelegate
        
        downloadGenres()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    /// Skip this preference
    @IBAction func skip(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showPeople", sender: nil)
    }
    
    /// Save this preference and go to the next view controller.
    @IBAction func next(_ sender: UIBarButtonItem) {
        saveMoviePrefs()
        performSegue(withIdentifier: "showPeople", sender: nil)
    }
    
    /// Download genres and display the results in the table view
    func downloadGenres() {
        TmdbClient.main.genreMovieList { [weak self] (apiResult) in
            guard let s = self else {
                return
            }
            
            switch apiResult {
            case .success(let result):
                s.genresDataSource.genres = result.genres
                s.tableView.reloadData()
            case .failure(let error):
                s.showAlert(title: "Genres Download Failed", message: error.localizedDescription)
            }
        }
    }
    
    /// Save the user selection to the movie prefs in the root view controller.
    func saveMoviePrefs() {
        // Get movie preferences from root view controller
        let rootVC = navigationController!.viewControllers.first as! ViewController
        var moviePrefs = rootVC.currentMoviePrefs
        // Get the genre objects from the user selection
        let indexPaths = tableView.indexPathsForSelectedRows ?? []
        let genres = indexPaths.map { self.genresDataSource.genres[$0.row] }
        moviePrefs.genres = Set(genres)
        // Update the movie prefs for the root view controller
        rootVC.updateMoviePrefs(moviePrefs)
    }
}
