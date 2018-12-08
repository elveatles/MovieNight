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
     Combine two sets of preferences to make one that can be used for a movie discovery query.
     
     - Parameter prefs0: One of the prefernce objects to combine.
     - Parameter prefs1: Another of the preference objects to combine.
     - Returns: The combined preferences.
    */
    static func combinePrefs(prefs0: MoviePrefs, prefs1: MoviePrefs) -> MoviePrefs {
        var result = MoviePrefs()
        
        result.genres = combineSets(set0: prefs0.genres, set1: prefs1.genres)
        result.people = combineSets(set0: prefs0.people, set1: prefs1.people)
        result.decades = combineSets(set0: prefs0.decades, set1: prefs1.decades)
        
        return result
    }
    
    /**
     Combine preference sets.
     
     At first, attempts to get common values between the sets, but
     if there is nothing in common, a set with all values from both sets is returned.
     
     - Parameter set0: One of the sets to combine.
     - Parameter set1: Another set to combine.
     - Returns: The sets combined into one.
    */
    static func combineSets<T>(set0: Set<T>, set1: Set<T>) -> Set<T> {
        var result = set0.intersection(set1)
        if result.isEmpty {
            result = set0.union(set1)
        }
        return result
    }
    
    /// Check if these preferences are ready to be used
    var isReady = false
    /// The genres the user likes
    var genres = Set<Genre>()
    /// People the user likes
    var people = Set<Person>()
    /// Release date decades the user likes.
    var decades = Set<Int>()
    
    /// Get the TMDbClient.discoverMovie primaryReleaseDateGte value from decades. nil is decades is empty.
    var releaseDateGte: Date? {
        guard let minYear = decades.min() else {
            return nil
        }
        
        var components = DateComponents()
        components.year = minYear
        return Calendar.current.date(from: components)
    }
    
    /// Get the TMDbClient.discoverMovie primaryReleaseDateLte value from decades. nil is decades is empty.
    var releaseDateLte: Date? {
        guard var maxYear = decades.max() else {
            return nil
        }
        
        maxYear += 9
        var components = DateComponents()
        components.year = maxYear
        components.month = 12
        components.day = 31
        return Calendar.current.date(from: components)
    }
}
