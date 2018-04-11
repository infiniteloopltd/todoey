//
//  ViewController.swift
//  todoey
//
//  Created by Fiach Reid on 10/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    
  
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        print(dataFilePath!)
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
           print("Failed to fetch context")
        }
      
    
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
        SaveData()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func SaveData()
    {
        
        do {
         try context.save()
        }
        catch{
            print("Failed to save data")
        }
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertText : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo ITem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (alertAction) in
            print(alertText.text!)
            let newItem = Item(context: self.context)
            newItem.title = alertText.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.SaveData()
            
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

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Failed to fetch context")
        }
        tableView.reloadData()
    }
}

