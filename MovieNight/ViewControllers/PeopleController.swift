//
//  PeopleController.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// User chooses which people they want for their preferences
class PeopleController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectionCountLabel: UILabel!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var prefsStatusView: PrefsStatusView!
    @IBOutlet var checkboxes: [UIImageView]!
    
    var rootViewController: ViewController {
        return navigationController!.viewControllers.first as! ViewController
    }
    private lazy var peopleDataSource = {
        return PeopleDataSource(tableView: tableView)
    }()
    private lazy var selectionDelegate: TableMultiSelectionDelegate = {
        return TableMultiSelectionDelegate(selectionCountLabel: selectionCountLabel, nextButton: nextButton)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = peopleDataSource
        tableView.prefetchDataSource = peopleDataSource
        tableView.delegate = selectionDelegate
        
        prefsStatusView.checkboxes = checkboxes
        
        peopleDataSource.fetchError = fetchError
        peopleDataSource.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prefsStatusView.update(with: rootViewController.currentMoviePrefs)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func skip(_ sender: UIBarButtonItem) {
        saveMoviePrefsSkip()
        performSegue(withIdentifier: "showReleaseDates", sender: nil)
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        saveMoviePrefs()
        performSegue(withIdentifier: "showReleaseDates", sender: nil)
    }
    
    /// Save preferences for a skip. Basically saves an empty set.
    func saveMoviePrefsSkip() {
        let rootVC = rootViewController
        var moviePrefs = rootVC.currentMoviePrefs
        moviePrefs.people = Set()
        rootVC.updateMoviePrefs(moviePrefs)
    }
    
    /// Save the user selection to the movie prefs in the root view controller.
    func saveMoviePrefs() {
        // Get movie preferences from root view controller
        let rootVC = rootViewController
        var moviePrefs = rootVC.currentMoviePrefs
        // Get the person objects from the user selection
        let indexPaths = tableView.indexPathsForSelectedRows ?? []
        let people = indexPaths.map { self.peopleDataSource.entities[$0.row] }
        moviePrefs.people = Set(people)
        // Update the movie prefs for the root view controller
        rootVC.updateMoviePrefs(moviePrefs)
    }
    
    private func fetchError(error: Error) {
        showAlert(title: "People Download Failure", message: error.localizedDescription)
    }
}
