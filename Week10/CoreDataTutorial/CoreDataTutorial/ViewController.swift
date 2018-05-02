//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Yeonhee Lee on 4/6/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // it loads the people array, fetch the data in it, and show it on the table
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            self.tableView.reloadData()
        } catch {
            print("Fetch Error!")
        }
    }

    @IBAction func onPlusTapped() {
        
        // shows a popup prompt window
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        // button of the popup window
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            
            let person = Person(context: PersistenceService.context)
            person.name = name
            person.age = Int16(age)!
            
            // save the input data
            PersistenceService.saveContext()
            
            // add the input data into the people array
            self.people.append(person)
            
            // reload the table view show that the new data will be shown on the table
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
 
}

extension ViewController: UITableViewDataSource {

    // ???
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // ???
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    // display the data in the people array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        return cell
    }
}

