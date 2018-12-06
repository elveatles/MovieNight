//
//  PeopleDataSource.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Data source for people such as actors, directors, writers, etc.
class PeopleDataSource: NSObject, UITableViewDataSource {
    var people = [Person]()
    private let tableImagesDownloader: TableImagesDownloader
    
    init(tableView: UITableView) {
        self.tableImagesDownloader = TableImagesDownloader(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        let person = people[indexPath.row]
        cell.configure(with: person)
        downloadOrAssignImage(cell: cell, indexPath: indexPath, url: person.profileURL)
        return cell
    }
    
    /**
     Download an image if it has not been downloaded, otherwise assign the image from the cache.
     
     - Parameter cell: The cell to assign the image to.
     - Parameter indexPath: The index path of the cell.
     - Parameter url: The url to download.
    */
    func downloadOrAssignImage(cell: PersonCell, indexPath: IndexPath, url: URL) {
        if let image = Cache.images[url] {
            cell.personImageView.image = image
        } else {
            // Assign different default image depending if the row is odd or even
            cell.personImageView.image = indexPath.row % 2 == 0 ? #imageLiteral(resourceName: "default") : #imageLiteral(resourceName: "default_odd")
            tableImagesDownloader.downloadImage(url: url, indexPath: indexPath)
        }
    }
}
