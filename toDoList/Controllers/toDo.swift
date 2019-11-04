//
//  ViewController.swift
//  toDoList
//
//  Created by z510 on 11/1/19.
//  Copyright © 2019 z510. All rights reserved.
//

import UIKit

class toDo: UITableViewController {
    
    var dolist = [Items]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        let newItem1 = Items()
        newItem1.title = "Sport"
        dolist.append(newItem1)
        
        let newItem2 = Items()
        newItem2.title = "Shopping"
        dolist.append(newItem2)
        
        let newItem3 = Items()
        newItem3.title = "Running"
        dolist.append(newItem3)
        
        if let items = defaults.array(forKey: "dolist") as? [Items]{
           dolist = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dolist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        //  let cell = UITableViewCell(style: .default, reuseIdentifier: "doCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "doCell", for: indexPath)
        
        let item = dolist[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ?  .checkmark :  .none

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        dolist[indexPath.row].done = !dolist[indexPath.row].done
        
        tableView.reloadData()
        
    }

    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new to Do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Items()
            newItem.title = textfield.text!

            self.dolist.append(newItem)
            self.defaults.set(self.dolist, forKey: "dolist")
            self.tableView.reloadData()
        
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "Enter New Item"
            textfield = alerttextfield
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    

}

