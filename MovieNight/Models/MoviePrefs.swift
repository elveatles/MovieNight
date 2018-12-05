//
//  MoviePrefs.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/3/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A user's movie preferences
struct MoviePrefs {
    /**
     Combine two sets of preferences to make one that can be used for a movie discovery query
     
     - Parameter prefs0: One of the prefernce objects to combine.
     - Parameter prefs1: Another of the preference objects to combine.
     - Returns: The combined preferences.
    */
    static func combinePrefs(prefs0: MoviePrefs, prefs1: MoviePrefs) -> MoviePrefs {
        var result = MoviePrefs()
        
        // Try to get common interests.
        result.genres = prefs0.genres.intersection(prefs1.genres)
        // If no common interests, include all prefernces from both
        if result.genres.isEmpty {
            result.genres = prefs0.genres.union(prefs1.genres)
        }
        
        // Do the same with people
        result.people = prefs0.people.intersection(prefs1.people)
        if result.people.isEmpty {
            result.people = prefs0.people.union(prefs1.people)
        }
        
        return result
    }
    
    /// Check if these preferences are ready to be used
    var isReady = false
    /// The genres the user likes
    var genres = Set<Genre>()
    /// People the user likes
    var people = Set<Person>()
}
