//
//  ReleaseDatesController.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/7/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// User chooses which decades the movies they're interested in.
class ReleaseDatesController: UIViewController {
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var selectionCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var prefsStatusView: PrefsStatusView!
    @IBOutlet var checkboxes: [UIImageView]!
    
    private let releaseDatesDataSource = ReleaseDatesDataSource()
    private lazy var selectionDelegate: TableMultiSelectionDelegate = {
        let result = TableMultiSelectionDelegate(selectionCountLabel: selectionCountLabel, nextButton: nextButton)
        result.targetSelectionCount = 2
        return result
    }()
    
    var rootViewController: ViewController {
        return navigationController?.viewControllers.first as! ViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = releaseDatesDataSource
        tableView.delegate = selectionDelegate
        
        prefsStatusView.checkboxes = checkboxes
        prefsStatusView.update(with: rootViewController.currentMoviePrefs)
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        saveMoviePrefs()
        navigationController?.popToRootViewController(animated: true)
    }
    
    /// Save preferences for a skip. Basically saves an empty set.
    func saveMoviePrefsSkip() {
        let rootVC = rootViewController
        var moviePrefs = rootVC.currentMoviePrefs
        moviePrefs.decades = Set()
        rootVC.updateMoviePrefs(moviePrefs)
    }
    
    /// Save the user selection to the movie prefs in the root view controller.
    func saveMoviePrefs() {
        // Get movie preferences from root view controller
        let rootVC = rootViewController
        var moviePrefs = rootVC.currentMoviePrefs
        // Get the person objects from the user selection
        let indexPaths = tableView.indexPathsForSelectedRows ?? []
        let decades = indexPaths.map { self.releaseDatesDataSource.decades[$0.row] }
        moviePrefs.decades = Set(decades)
        // Update the movie prefs for the root view controller
        rootVC.updateMoviePrefs(moviePrefs)
    }
}
