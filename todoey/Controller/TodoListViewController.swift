//
//  ViewController.swift
//  todoey
//
//  Created by Fiach Reid on 10/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: BaseTableViewController {

    let realm = try! Realm()
    
    var todoItems : Results<Item>? = nil
    
    var selectedCategory : Category? {
        didSet{
            LoadItems()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        print(dataFilePath!)
      
    
    }
    
    override func updateModel(at indexPath: IndexPath) {
        do {
            try self.realm.write {
                self.realm.delete(self.todoItems![indexPath.row])
            }
        }
        catch{
            print("Failed to save data")
        }
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = todoItems?[indexPath.row];
        if item != nil
        {
            cell.textLabel?.text = item!.title
            cell.accessoryType = item!.done ? .checkmark : .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoItems![indexPath.row])
       
        do{
            try realm.write {
                todoItems![indexPath.row].done = !todoItems![indexPath.row].done
            }
        }catch{
            print("Failed to save \(error)")
        }
       
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
 
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertText : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo ITem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (alertAction) in
            print(alertText.text!)
            do
            {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = alertText.text!
                    self.selectedCategory?.items.append(newItem)
                }
            }
            catch{
                print("Failed to save \(error)")
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add to do item"
            alertText = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
   func LoadItems()
    {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
        let filter = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        todoItems = todoItems?.filter(filter).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! == ""
        {
            LoadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

