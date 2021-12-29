//
//  RealTimeDatabaseTableViewController.swift
//  LoodosCase
//
//  Created by Can on 1.12.2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class RealTimeDatabaseTableViewController: UITableViewController {
    
    var database = Database.database().reference()
    var userIDs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userIDs.count+1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rdCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Generate user ID"
        } else {
            database.child("something_\(userIDs[indexPath.row-1])").observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value as? [String: String] else {
                    return
                }
                
                print(value.description)
                cell.textLabel?.text = value["name"]
                cell.detailTextLabel?.text = value["user_id"]
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let randomID = String(Int.random(in: 1..<100000))
            let name = "Hello"
            
            let object: [String: String] = [
                "user_id": randomID,
                "name": name,
            ]
            
            database.child("something_\(randomID)").setValue(object)
            
            userIDs.append(randomID)
            self.tableView.reloadData()
        }
    }
        
}
