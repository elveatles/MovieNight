//
//  DecadeCell.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/7/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Shows a selectable decade.
class DecadeCell: UITableViewCell {
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    
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

}
