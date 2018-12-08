//
//  TableMultiSelection.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Limits multiple selection.
/// Updates "selected" label and "next" button.
class TableMultiSelectionDelegate: NSObject, UITableViewDelegate {
    /// The target number of cells the user should select
    var targetSelectionCount: Int = 5
    /// A label that displays "x out of y selected".
    var selectionCountLabel: UILabel
    /// The button the user taps to go to the next screen when they are done making their selection.
    var nextButton: UIBarButtonItem
    
    /**
     Initialize with required UI elements.
     
     - Parameter selectedLabel: A label that displays "x out of y selected".
     - Parameter nextButton: The button the user taps to go to the next screen when they are done making their selection.
    */
    init(selectionCountLabel: UILabel, nextButton: UIBarButtonItem) {
        self.selectionCountLabel = selectionCountLabel
        self.nextButton = nextButton
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Limit the number of cells that are allowed to be selected
        let selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
        guard selectedCount < targetSelectionCount else {
            return nil
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateForSelection(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateForSelection(tableView: tableView)
    }
    
    /// Update the UI based on the current user selection
    func updateForSelection(tableView: UITableView) {
        let selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
        selectionCountLabel.text = "\(selectedCount) of \(targetSelectionCount) selected"
        nextButton.isEnabled = selectedCount == targetSelectionCount
    }
}
