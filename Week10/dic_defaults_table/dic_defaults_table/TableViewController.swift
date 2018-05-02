//
//  TableViewController.swift
//  dic_defaults_table
//
//  Created by Yeonhee Lee on 4/21/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "TableViewCell"

struct Scrap {
    var imageId: String
    var text: String?
}

class TableViewController: UITableViewController {
 
//    @IBOutlet weak var addList: UIBarButtonItem!
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    // I want to save this structure to UserDefaults, but it seems like UserDefaults doesn't accept user-defined structure ??
    var scrapbooks = [String : [Scrap]]()
//    var scrapbooks: NSMutableDictionary = [String: [Scrap]]() as! NSMutableDictionary
    var books = [[Any]]()
    var labels: [String] = []
    
//    var newLabel: String = ""
    
    override func viewDidLoad() {
        
//        if let s = UserDefaults.standard.array(forKey: "labels") as? [String] {
//            labels = s
//        } else {
//            labels = ["No Label"]
//        }
//        print(labels)
        
//        if let scr = UserDefaults.standard.dictionary(forKey: "scrapbooks") as? [String: [Scrap]] {
//            scrapbooks = scr
//        } else {
//            let dummyScrap = Scrap(imageId: "zzz", text: "dummy")
//            scrapbooks = [
//                "No Label" : [dummyScrap]
//            ]
//
//        }
        
        // Retrieving data, but it is successulyy loaded only first at first and crashes thereafter
        if let bk = UserDefaults.standard.array(forKey: "books") as? [[Any]] {
//            books = bk
            
            var l: String
            var i: [String]
            var m: [String]
            var tempArr = [Any]()
            
            // Did this because when the "books" was just retrieved from UserDefaults, inside arrays in "books" are not String array type so they cause a crash
            // But this part cause an error once a user create a new label, then kiiled the app and run it again
            for x in 0...bk.count {
                l = bk[x][0] as! String
                i = bk[x][1] as! [String]
                m = bk[x][2] as! [String]
                tempArr = [l, i, m]
                books.append(tempArr)
            }
            
        } else {
            let dummyArr = ["No Label", ["dummy_id"], ["dummy_text"]] as [Any]
            books.append(dummyArr)
        }
        
        print("load...")
//        print(scrapbooks)
        print(books)
        
        super.viewDidLoad()
    }
    
    // When the 'Add' button is tapped, present an alert popup with a textfield, so that user can create a new label
    // But, don't know how to make the new label immediately appears on the list
    @IBAction func addListTapped(_ sender: UIBarButtonItem) {
        
        let popup = UIAlertController(title: "Add New Label", message: "Enter a new label and press OK", preferredStyle: .alert)
        
        popup.addTextField { (textField) in
            textField.placeholder = "New Label"
            textField.keyboardType = .default
        }
        
        let actionOk = UIAlertAction(title: "OK", style: .default) { (action) in
            let newLabel = (popup.textFields?.first?.text!)!
//            let newScrap = Scrap(imageId: "xxx", text: "text message")
            let newArr: [Any] = [newLabel, ["id02"], ["text02"]]
            
            print(newLabel)
//            print(self.labels)
            print(self.books)
//            print(self.scrapbooks)
            
//            self.labels.append(newLabel)
//            self.scrapbooks[newLabel] = [newScrap]
//            self.scrapbooks.setObject([newScrap], forKey: newLabel as NSCopying)
//            self.scrapbooks[newLabel] = [newScrap]
            
            self.books.append(newArr)
            
            print("****")
//            print(self.labels)
//            print(self.scrapbooks)
            print(self.books)
            print("****")
            
//            UserDefaults.standard.set(self.labels, forKey: "labels")
//            UserDefaults.standard.set(self.scrapbooks, forKey: "scrapbooks")
            UserDefaults.standard.set(self.books, forKey: "books")
            
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("CANCELLED")
        }
        
        popup.addAction(actionOk)
        popup.addAction(actionCancel)
        
        present(popup, animated: true, completion: nil)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return labels.count
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        
//        let bookLabel = labels[indexPath.row]
        let bookLabel: String = books[indexPath.row][0] as! String
        let b: [Any] = books[indexPath.row]
       
        cell.label.text = bookLabel
        
        
//        let tempArr = scrapbooks[bookLabel] as? [Scrap]
        
//        if tempArr != nil {
//            print(tempArr)
//            cell.count.text = String(tempArr!.count)
//        } else {
//            cell.count.text = "0"
//        }
        
        let content = b[1] as! [Any]
        cell.count.text = String(content.count)
        
        return cell
    }
    
    // pass the ids and text memos to the collection view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        print("Selected Table Row: \(selectedRow)")
        
        let vc = segue.destination as! CollectionViewController
//        let l = labels[selectedRow]
//        let sc = scrapbooks[l] as! [Scrap]
        let bk = books[selectedRow]
        print(bk)
//        vc.scraps = sc
//        vc.book = bk
        vc.ids = bk[1] as! Array
        vc.memos = bk[2] as! Array

    }
}
