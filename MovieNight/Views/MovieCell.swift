//
//  MovieCell.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/6/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// A cell that shows movie data
class MovieCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailTextLabel?.textColor = UIColor(white: 0.0, alpha: 0.4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     Configure the cell with a movie.
     
     - Parameter movie: The movie to configure with.
     */
    func configure(with movie: Movie?) {
        guard let m = movie else {
            textLabel?.text = ""
            detailTextLabel?.text = ""
            activityIndicator.startAnimating()
            return
        }
        
        textLabel?.text = m.title
        
        // Set the year
        if let releaseDate = m.releaseDate {
            let year = Calendar.current.component(.year, from: releaseDate)
            detailTextLabel?.text = "\(year)"
        } else {
            detailTextLabel?.text = "????"
        }
        
        activityIndicator.stopAnimating()
    }
}
