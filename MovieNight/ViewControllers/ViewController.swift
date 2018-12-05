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
    
    let tmdbClient = TmdbClient(apiKey: ApiKey.tmdb)
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
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    /// Clear movie any movie preferences chosen
    @IBAction func clearMoviePrefs(_ sender: UIBarButtonItem) {
        moviePrefs = [MoviePrefs(), MoviePrefs()]
        user0Button.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
        user1Button.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
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
        moviePrefs[moviePrefsIndex] = newMoviePrefs
        
        if newMoviePrefs.genres != nil || newMoviePrefs.people != nil {
            let userButton = moviePrefsIndex == 0 ? user0Button! : user1Button!
            userButton.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
        }
    }
}

