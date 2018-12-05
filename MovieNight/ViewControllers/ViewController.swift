//
//  ViewController.swift
//  MovieNight
//
//  Created by Erik Carlson on 11/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Main view controller where a user can start to choose preferences or view results after preferences are chosen.
class ViewController: UIViewController {
    @IBOutlet weak var user0Button: UIButton!
    @IBOutlet weak var user1Button: UIButton!
    @IBOutlet weak var viewResultsButton: UIButton!
    
    var moviePrefs = [MoviePrefs(), MoviePrefs()]
    
    /// The movie preferences for the currently chosen user
    var currentMoviePrefs: MoviePrefs {
        return moviePrefs[moviePrefsIndex]
    }
    
    /// The index of the current user being edited.
    var moviePrefsIndex = 0 {
        didSet {
            // Make sure the index is in range
            if !moviePrefs.indices.contains(moviePrefsIndex) {
                moviePrefsIndex = oldValue
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        
        viewResultsButton.layer.cornerRadius = 8
        enableResultsButton(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovies" {
            // Create combined user preferences to show movie results.
            let vc = segue.destination as! MoviesController
            vc.moviePrefs = MoviePrefs.combinePrefs(prefs0: moviePrefs[0], prefs1: moviePrefs[1])
        }
     }
    
    /// Clear movie any movie preferences chosen
    @IBAction func clearMoviePrefs(_ sender: UIBarButtonItem) {
        moviePrefs = [MoviePrefs(), MoviePrefs()]
        user0Button.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
        user1Button.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
        enableResultsButton(false)
    }
    
    @IBAction func user0Selected() {
        moviePrefsIndex = 0
        performSegue(withIdentifier: "showGenres", sender: nil)
    }
    
    @IBAction func user1Selected() {
        moviePrefsIndex = 1
        performSegue(withIdentifier: "showGenres", sender: nil)
    }
    
    /**
     Update the movie prefs for the current index.
     
     - Parameter newMoviePrefs: The new movie preferences to update with.
    */
    func updateMoviePrefs(_ newMoviePrefs: MoviePrefs) {
        // Update the preferences for the current user
        var prefs = newMoviePrefs
        prefs.isReady = true
        moviePrefs[moviePrefsIndex] = prefs
        
        // Show that the user has made their choice
        let userButton = moviePrefsIndex == 0 ? user0Button! : user1Button!
        userButton.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
        
        // Check if all users made their choices.
        // If so, enable the viewResults button.
        let ready = moviePrefs.map { $0.isReady }
        if !ready.contains(false) {
            enableResultsButton(true)
        }
    }
    
    /**
     Enable/disable the "View Results" button.
     
     - Parameter doEnable: Whether to enable the button or not.
    */
    private func enableResultsButton(_ doEnable: Bool) {
        viewResultsButton.isEnabled = doEnable
        if doEnable {
            viewResultsButton.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.2862745098, blue: 0.2862745098, alpha: 1)
        } else {
            viewResultsButton.backgroundColor = #colorLiteral(red: 0.4080747672, green: 0.2571114954, blue: 0.2596275499, alpha: 1)
        }
    }
}

