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
    /// The table view that is affected.
    let tableView: UITableView
    /// Callback for when fetch errors occur.
    var fetchError: ((Error) -> Void)? {
        didSet {
            pagedDataSource.fetchError = fetchError
        }
    }
    private let pagedDataSource: PagedDataSource<Person>
    private let tableImagesDownloader: TableImagesDownloader
    
    /// Get the fetched entities
    var entities: [Person] {
        return pagedDataSource.entities
    }
    
    /**
     Initializer.
     
     - Parameter tableView: The table view to be affected by the data.
    */
    init(tableView: UITableView) {
        self.tableView = tableView
        self.pagedDataSource = PagedDataSource(tableView: tableView)
        self.tableImagesDownloader = TableImagesDownloader(tableView: tableView)
        
        super.init()
        
        self.pagedDataSource.apiRequest = TmdbClient.main.personPopular
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagedDataSource.totalResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        
        // Default image is different depending if the row is even or odd.
        let defaultImage = indexPath.row % 2 == 0 ? #imageLiteral(resourceName: "default") : #imageLiteral(resourceName: "default_odd")
        
        if pagedDataSource.isLoadingCell(indexPath: indexPath) {
            cell.configure(with: nil)
            cell.personImageView.image = defaultImage
        } else {
            let person = pagedDataSource.entities[indexPath.row]
            cell.configure(with: person)
            if let imageView = cell.personImageView {
                tableImagesDownloader.downloadOrAssignImage(imageView: imageView, indexPath: indexPath, url: person.profileURL, defaultImage: defaultImage)
            }
        }
        
        return cell
    }
    
    /// Fetch more results
    func fetch() {
        pagedDataSource.fetch()
    }
}

extension PeopleDataSource: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // Fetch more results if we scroll to cells that have not been loaded yet.
        if indexPaths.contains(where: pagedDataSource.isLoadingCell) {
            fetch()
        }
    }
}
