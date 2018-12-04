//
//  GenresDataSource.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/3/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Data source for genres table view
class GenresDataSource: NSObject, UITableViewDataSource {
    /// The available movie genres
    var genres = [Genre]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        let genre = genres[indexPath.row]
        cell.configure(with: genre)
        return cell
    }
}
