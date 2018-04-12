//
//  CategoryTableViewController.swift
//  todoey
//
//  Created by Fiach Reid on 11/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
            let newCategory = Category(context: self.context)
            newCategory.name = alertText.text!
         
            self.categoryArray.append(newCategory)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        let indexPath = tableView.indexPathForSelectedRow!
        destinationVC.selectedCategory = categoryArray[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row];
        cell.textLabel?.text = category.name
        return cell
    }

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }

    // MARK: - Data manipulation methods
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest())
    {
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Failed to fetch context")
        }
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

}
