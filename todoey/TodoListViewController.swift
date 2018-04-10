//
//  ViewController.swift
//  todoey
//
//  Created by Fiach Reid on 10/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["itam A","item B","item C","item D"]
    
    var defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let savedObject = defaults.object(forKey: "todolist")
        if (savedObject != nil)
        {
            itemArray = savedObject as! [String]
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark
        {
            cell?.accessoryType = .none
        }
        else
        {
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertText : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo ITem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (alertAction) in
      
            print(alertText.text!)
            self.itemArray.append(alertText.text!)
            self.defaults.set(self.itemArray, forKey: "todolist")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add to do item"
            alertText = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}

