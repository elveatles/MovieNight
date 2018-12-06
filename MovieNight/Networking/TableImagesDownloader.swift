//
//  TableImagesDownloader.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Used for downloading images for a UITableView
class TableImagesDownloader {
    let tableView: UITableView
    private let downloadQueue = OperationQueue()
    private(set) var downloadsInProgress = [IndexPath: Operation]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    /**
    Download an image for a table cell.
    
    - Parameter url: The image url to download.
    - Parameter tableView: The table view the download is for.
    - Parameter indexPath: The index path of the cell the download is for.
    */
    func downloadImage(url: URL, indexPath: IndexPath) {
        // Check if this image is already downloading
        if let _ = downloadsInProgress[indexPath] {
            return
        }
        
        // Create the image download operation
        let downloader = ImageDownloader(url: url)
        
        downloader.completionBlock = {
            DispatchQueue.main.async {
                self.downloadsInProgress.removeValue(forKey: indexPath)
                
                if downloader.isCancelled {
                    return
                }
                
                // The result should only be nil if the operation was cancelled.
                guard let downloadResult = downloader.result else {
                    return
                }
                
                // Cache the image and reload the row which should assign the cached image to the cell
                switch downloadResult {
                case .success(let result):
                    Cache.images[url] = result
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        downloadsInProgress[indexPath] = downloader
        downloadQueue.addOperation(downloader)
    }
}
