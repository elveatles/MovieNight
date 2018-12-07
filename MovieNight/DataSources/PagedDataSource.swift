//
//  PagedDataSource.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/6/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// General data source functionality for UITableView that fetches paged data.
class PagedDataSource<T: Codable> {
    /// The table view that is affected.
    let tableView: UITableView
    /// A callback for when fetch errors occur.
    var fetchError: ((Error) -> Void)?
    private let pageFetcher: PageFetcher<T>
    
    /// The client API function used for fetching more entities.
    /// Should only be assigned once.
    var apiRequest: PageFetcher<T>.ApiRequest? {
        get {
            return pageFetcher.apiRequest
        }
        
        set {
            pageFetcher.apiRequest = newValue
        }
    }
    
    /// Get the fetched entities
    var entities: [T] {
        return pageFetcher.entities
    }
    
    /// Get the count of fetched entities
    var entitiesCount: Int {
        return pageFetcher.entities.count
    }
    
    /// The total number of entities
    var totalResults: Int {
        return pageFetcher.totalResults
    }
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.pageFetcher = PageFetcher()
    }
    
    /// Fetch more results
    func fetch() {
        pageFetcher.fetch { [weak self] (apiResult) in
            guard let s = self else {
                return
            }
            
            switch apiResult {
            case .success(let result):
                if result.page == 1 {
                    s.tableView.reloadData()
                } else {
                    let indexPathsToReload = s.calculateIndexPathsToReload(from: result.results)
                    let visibleIndexPaths = s.visibleIndexPathsToReload(intersecting: indexPathsToReload)
                    s.tableView.reloadRows(at: visibleIndexPaths, with: .automatic)
                }
            case .failure(let error):
                if let callback = s.fetchError {
                    callback(error)
                }
            }
        }
    }
    
    /**
     Check if a cell is loading/needs to be loaded.
     
     - Parameter indexPath: The index of the cell to check.
     - Returns: true if the cell needs to be loaded.
     */
    func isLoadingCell(indexPath: IndexPath) -> Bool {
        return indexPath.row >= entitiesCount
    }
    
    /**
     Calculate which cell indexes need to be reloaded when new people are added.
     
     - Parameter newPeople: The people that were added.
     - Returns: The index paths to reload.
     */
    private func calculateIndexPathsToReload(from newEntities: [T]) -> [IndexPath] {
        let startIndex = entitiesCount - newEntities.count
        let range = startIndex..<entitiesCount
        return range.map { IndexPath(row: $0, section: 0) }
    }
    
    /**
     Calculate visible index paths to reload.
     
     - Parameter indexPaths: Index paths to reload. These may or may not be visible.
     - Returns: The visible index paths from indexPaths.
     */
    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
