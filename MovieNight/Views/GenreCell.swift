//
//  GenreCell.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/3/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Cell for the genre view controller
class GenreCell: UITableViewCell {
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            checkboxImageView.image = #imageLiteral(resourceName: "checked")
        } else {
            checkboxImageView.image = #imageLiteral(resourceName: "unchecked")
        }
    }
    
    /**
     Configure the cell with a genre.
     
     - Parameter genre: The genre to configure with.
    */
    func configure(with genre: Genre) {
        self.genreLabel.text = genre.name
    }
    
}
