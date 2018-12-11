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
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
            titleLabel.text = ""
            yearLabel.text = ""
            activityIndicator.startAnimating()
            return
        }
        
        titleLabel.text = m.title
        
        // Set the year
        if let releaseDate = m.releaseDate {
            let year = Calendar.current.component(.year, from: releaseDate)
            yearLabel.text = "\(year)"
        } else {
            yearLabel.text = "????"
        }
        
        activityIndicator.stopAnimating()
    }
}
