//
//  ImageDownloader.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Error related to a download
enum DownloadError: Error {
    /// Something is wrong with the data
    case invalidData
}

/// Result from a download.
enum DownloadResult<T> {
    case success(result: T)
    case failure(error: Error)
}

/// Downloads an image
class ImageDownloader: Operation {
    /// The url to download
    let url: URL
    /// The result to check in the completion block
    var result: DownloadResult<UIImage>?
    
    init(url: URL) {
        self.url = url
        
        super.init()
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        do {
            let imageData = try Data(contentsOf: url)
            
            if isCancelled {
                return
            }
            
            if imageData.isEmpty {
                result = .failure(error: DownloadError.invalidData)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                result = .failure(error: DownloadError.invalidData)
                return
            }
            
            result = .success(result: image)
        } catch {
            result = .failure(error: error)
        }
    }
}
