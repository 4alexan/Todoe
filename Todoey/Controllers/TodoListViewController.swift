//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
//    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let encoder = PropertyListEncoder()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let item = itemArray[indexPath.row]
        
        // Configure the cell’s contents.
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.value ? .checkmark : .none
           
       return cell
    }
    
    // MARK: - Table View Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].value = !itemArray[indexPath.row].value
        self.saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add new item
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        alert.message = "Add next todoey"
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.value = false
            
            if textField.text! != "" {
                self.itemArray.append(newItem)
                self.saveItems()
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            alertTextField.autocapitalizationType = .sentences
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
//    func loadItems() {
//        // Load crypto coins
//        if let itemsData = try? Data(contentsOf: filePath!) {
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemArray = try decoder.decode([Item].self, from: itemsData)
//            } catch {
//                print("Error decoding cryptoData array, \(error)")
//            }
//        }
//    }
        
    
}

