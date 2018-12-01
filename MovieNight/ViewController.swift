//
//  ViewController.swift
//  MovieNight
//
//  Created by Erik Carlson on 11/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tmdbClient = TmdbClient(apiKey: ApiKey.tmdb)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tmdbClient.genreMovieList { (result) in
            switch result {
            case .success(let result): print(result)
            case .failure(let error): print(error)
            }
        }
    }


}

