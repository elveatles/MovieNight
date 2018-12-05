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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        let person = people[indexPath.row]
        cell.configure(with: person)
        return cell
    }
}
