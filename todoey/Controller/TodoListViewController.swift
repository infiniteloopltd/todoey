//
//  ViewController.swift
//  todoey
//
//  Created by Fiach Reid on 10/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [ToDoItem]()
    
    var defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemArray.append(ToDoItem(with:"one"))
        itemArray.append(ToDoItem(with:"two"))
        itemArray.append(ToDoItem(with:"three"))
        itemArray.append(ToDoItem(with:"four"))
        itemArray.append(ToDoItem(with:"five"))
        itemArray.append(ToDoItem(with:"six"))
        itemArray.append(ToDoItem(with:"seven"))
        itemArray.append(ToDoItem(with:"eight"))
        itemArray.append(ToDoItem(with:"nine"))
        itemArray.append(ToDoItem(with:"ten"))
        // Do any additional setup after loading the view, typically from a nib.
        /*let savedObject = defaults.object(forKey: "todolist")
        if (savedObject != nil)
        {
            itemArray = savedObject as! [String]
        }*/
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row];
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertText : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo ITem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (alertAction) in
      
            print(alertText.text!)
            let newItem = ToDoItem(with: alertText.text!)
            self.itemArray.append(newItem)
            //self.defaults.set(self.itemArray, forKey: "todolist")
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

