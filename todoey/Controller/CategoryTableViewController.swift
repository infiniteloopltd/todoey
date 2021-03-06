//
//  CategoryTableViewController.swift
//  todoey
//
//  Created by Fiach Reid on 11/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryTableViewController: BaseTableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
      
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // add a category
        var alertText : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: UIAlertActionStyle.default) { (alertAction) in
            print(alertText.text!)
            let newCategory = Category()
            newCategory.name = alertText.text!
         
            self.Save(category: newCategory)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add to do item"
            alertText = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("performing goToItems segue")
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("setting selectedCategory on destination View Controller")
        let destinationVC = segue.destination as! TodoListViewController
        let indexPath = tableView.indexPathForSelectedRow!
        destinationVC.selectedCategory = categoryArray?[indexPath.row];
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let category = categoryArray?[indexPath.row];
        cell.textLabel?.text = category?.name
        cell.backgroundColor = UIColor(hexString: category?.colour ?? "000000")
        cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn:cell.backgroundColor!, isFlat:true)
        return cell
    }

    override func updateModel(at indexPath: IndexPath) {
        do {
            try self.realm.write {
                self.realm.delete(self.categoryArray![indexPath.row])
            }
        }
        catch{
            print("Failed to save data")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 0
    }

    // MARK: - Data manipulation methods
    func loadCategories()
    {
         categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    func Save(category: Category)
    {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Failed to save data")
        }
    }
}

