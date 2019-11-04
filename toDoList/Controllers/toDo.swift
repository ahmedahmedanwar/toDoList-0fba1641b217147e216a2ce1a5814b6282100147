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
    let dataFilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
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
        
        
        
    
        
//        if let items = defaults.array(forKey: "dolist") as? [Items]{
//           dolist = items
//        }
    }
    
    // Mark DataSource Method
    
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
    
    //Mark Delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dolist[indexPath.row].done = !dolist[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveditems()
    }

    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new to Do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Items()
            newItem.title = textfield.text!

            self.dolist.append(newItem)
            
   //         self.defaults.set(self.dolist, forKey: "dolist")
                
            self.saveditems()
            self.tableView.reloadData()
        
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "Enter New Item"
            textfield = alerttextfield
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    func saveditems (){
        
        let encoder = PropertyListEncoder()

        do{
         let data = try encoder.encode(dolist)
             
             try data.write(to: dataFilepath!)
             
         }catch{
             
             print("error \(error)")
         }
         
        tableView.reloadData()
        
    }


}

