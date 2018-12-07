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
        tableView.delegate = self
        
        peopleDataSource.fetchError = fetchError
        peopleDataSource.fetch()
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
        print("performSegue")
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        saveMoviePrefs()
        print("performSegue")
    }
    
    /// Save the user selection to the movie prefs in the root view controller.
    func saveMoviePrefs() {
        // Get movie preferences from root view controller
        let rootVC = navigationController!.viewControllers.first as! ViewController
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

extension PeopleController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return selectionDelegate.tableView(tableView, willSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectionDelegate.tableView(tableView, didDeselectRowAt: indexPath)
    }
    /*
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Load more results when tableView has scrolled to the bottom.
        let lastElement = peopleDataSource.people.count - 1
        if indexPath.row == lastElement {
            loadNextPage()
        }
    }
    */
}
