//
//  ViewController.swift
//  todoey
//
//  Created by Fiach Reid on 10/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["itam A","item B","item C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }


}

