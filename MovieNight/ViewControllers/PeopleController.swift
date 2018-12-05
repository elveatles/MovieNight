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
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let peopleDataSource = PeopleDataSource()
    private lazy var selectionDelegate: TableMultiSelectionDelegate = {
        return TableMultiSelectionDelegate(selectionCountLabel: selectionCountLabel, nextButton: nextButton)
    }()
    private var latestPage: Page<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = peopleDataSource
        tableView.delegate = self
        
        latestPage = Stub.popularPeople(page: 1)
        peopleDataSource.people = latestPage!.results
        
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
    
    @IBAction func skip(_ sender: UIBarButtonItem) {
        print("performSegue")
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        saveMoviePrefs()
        print("performSegue")
    }
    
    /// Load the next page of people
    func loadNextPage() {
        // latestPage should be set
        guard let page = latestPage else {
            return
        }
        
        // If we are at the last page, no need to load more
        guard page.page < page.totalPages && page.page < TmdbClient.maxPage else {
            return
        }
        
        footerView.isHidden = false
        activityIndicator.startAnimating()
        
        // Test
        latestPage = Stub.popularPeople(page: page.page + 1)
        
        tableView.beginUpdates()
        peopleDataSource.people += latestPage!.results
        let startRow = peopleDataSource.people.count - latestPage!.results.count
        let range = startRow..<peopleDataSource.people.count
        let indexPaths = range.map { IndexPath(row: $0, section: 0) }
        print("insert at: \(indexPaths)")
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
        
        footerView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    /// Save the user selection to the movie prefs in the root view controller.
    func saveMoviePrefs() {
        // Get movie preferences from root view controller
        let rootVC = navigationController!.viewControllers.first as! ViewController
        var moviePrefs = rootVC.currentMoviePrefs
        // Get the person objects from the user selection
        let indexPaths = tableView.indexPathsForSelectedRows ?? []
        moviePrefs.people = indexPaths.map { self.peopleDataSource.people[$0.row] }
        // Update the movie prefs for the root view controller
        rootVC.updateMoviePrefs(moviePrefs)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Load more results when tableView has scrolled to the bottom.
        let lastElement = peopleDataSource.people.count - 1
        if indexPath.row == lastElement {
            loadNextPage()
        }
    }
}
