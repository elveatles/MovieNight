//
//  PersonCell.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// A cell for a person such as an actor, director, producer, etc.
class PersonCell: UITableViewCell {
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
     Configure the cell with a person.
     
     - Parameter person: The person to configure with.
     */
    func configure(with person: Person?) {
        guard let p = person else {
            self.nameLabel.text = ""
            activityIndicator.startAnimating()
            return
        }
        
        self.nameLabel.text = p.name
        activityIndicator.stopAnimating()
    }
}
