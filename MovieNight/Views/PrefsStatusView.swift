//
//  PrefsStatusView.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/10/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// View for showing which selections have been made.
class PrefsStatusView: UIView {
    /// Indexes for checkboxes
    enum CheckboxIndex: Int {
        case genres
        case people
        case releaseDate
    }
    let prefsCount = 3
    
    /// Checkboxes that show which preferences have been completed (as opposed to skipped).
    var checkboxes = [UIImageView]()
    
    /**
     Update the checkboxes with the given movie preferences.
     
     - Parameter moviePrefs: The movie prefs to update with.
    */
    func update(with moviePrefs: MoviePrefs) {
        guard checkboxes.count >= prefsCount else {
            print("PrefsStatusView.update: checkboxes array not setup properly.")
            return
        }
        
        // Genres
        var index = CheckboxIndex.genres.rawValue
        var isChecked = !moviePrefs.genres.isEmpty
        setIsChecked(imageView: checkboxes[index], isChecked: isChecked)
        
        // People
        index = CheckboxIndex.people.rawValue
        isChecked = !moviePrefs.people.isEmpty
        setIsChecked(imageView: checkboxes[index], isChecked: isChecked)
        
        // Release Date
        index = CheckboxIndex.releaseDate.rawValue
        isChecked = !moviePrefs.decades.isEmpty
        setIsChecked(imageView: checkboxes[index], isChecked: isChecked)
    }
    
    /**
     Set an imageView to checked or unchecked.
     
     - Parameter imageView: The image view to set.
     - Parameter isChecked: Whether the image is checked.
    */
    func setIsChecked(imageView: UIImageView, isChecked: Bool) {
        if isChecked {
            imageView.image = #imageLiteral(resourceName: "checked")
        } else {
            imageView.image = #imageLiteral(resourceName: "unchecked")
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
