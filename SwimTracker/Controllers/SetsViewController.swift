//
//  SetsViewController.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/23/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import UIKit
import RealmSwift


class SetsViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sets: Results<Sets>?
    let realm = try! Realm()
    var selectedWorkout: Workouts? {
        didSet {
            loadSets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        navigationItem.title = selectedWorkout?.name
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//      if let colourHex = selectedWorkout?.colour {
//          title = selectedWorkout!.name
//            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
//            }
//           if let navBarColour = UIColor(hexString: colourHex) {
//                //Original setting: navBar.barTintColor = UIColor(hexString: colourHex)
//                //Revised for iOS13 w/ Prefer Large Titles setting:
//               navBar.backgroundColor = navBarColour
//               navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
//                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
//                searchBar.barTintColor = navBarColour
//            }
//       }
// }
    
    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let set = sets?[indexPath.row] {
            cell.textLabel?.text = set.title
//            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(toDoItems!.count)) {
//                cell.backgroundColor = colour
//                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
//            }
//            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Sets Added"
        }
        
        return cell
    }
    
    //Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let set = sets?[indexPath.row] {
//            do {
//                try realm.write{
//                    // realm.delete(item)
//                set.done = !set.done
//                }
//            } catch {
//                print("Error saving done status, \(error)")
//            }
//        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Set", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add Set", style: .default) { (action) in
            if let currentWorkout = self.selectedWorkout {
                do {
                    try self.realm.write {
                        let newSet = Sets()
                        newSet.title = textField.text!
                        newSet.dateCreated = Date()
                        currentWorkout.sets.append(newSet)
                    }
                } catch {
                    print("Error saving new sets, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new set"
            textField = alertTextField
        }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //Mark - Model Manipulation Methods
    func loadSets() {
        sets = selectedWorkout?.sets.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let set = sets?[indexPath.row] {
            do {
                try realm.write{
                    realm.delete(set)
                    loadSets()
                }
            } catch {
                print("Error deleting set, \(error)")
            }
        }
    }
}


//Mark: - Searchbar delegate methods
extension SetsViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        sets = sets?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadSets()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
    
}
