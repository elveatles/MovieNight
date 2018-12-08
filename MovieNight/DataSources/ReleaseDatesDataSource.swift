//
//  ReleaseDatesDataSource.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/7/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Data source for displaying selectable decades.
class ReleaseDatesDataSource: NSObject, UITableViewDataSource {
    /// All release date decades from 1870 until the current decade.
    let decades: [Int] = {
        var result = [Int]()
        
        let currentYear = Calendar.current.component(.year, from: Date())
        var year = 1870
        while year < currentYear {
            result.append(year)
            year += 10
        }
        
        return result.reversed()
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DecadeCell", for: indexPath) as! DecadeCell
        
        let data = decades[indexPath.row]
        cell.yearLabel.text = "\(data)s"
        
        return cell
    }
}
