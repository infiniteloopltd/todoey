//
//  BaseTableViewController.swift
//  todoey
//
//  Created by Fiach Reid on 14/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import SwipeCellKit

class BaseTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
       func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if orientation != .right
        {
            return nil
        }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("delete cell")
            self.updateModel(at: indexPath)
           
       }
       deleteAction.image=#imageLiteral(resourceName: "delete")
       return [deleteAction]
    }
    
    func updateModel(at indexPath: IndexPath)
    {
        // Does nothing. Must be overridden
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
       
        return cell
    }

}
