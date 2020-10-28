//
//  MenuViewController.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/19/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class FeedViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    // Potential namespace clash with OpaquePointer (same name of Category)
    // Use correct type from dropdown or add backticks to fix e.g., var categories = [`Category`]()
    var workouts: Results<Workouts>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.separatorStyle = .none
        
        
    }
    
        override func viewWillAppear(_ animated: Bool) {
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
            }
            navBar.backgroundColor = UIColor(hexString: "#00BBFF")
//            navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 30)!]
        }
    
    //Mark: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = workouts?[indexPath.row].name ?? "No Workouts added yet"
        
        //        if let workout = workouts?[indexPath.row] {
        //            guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
        //            cell.backgroundColor = categoryColour
        //            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        //        }
        return cell
    }
    
    
    //Mark: - Data Manipulation Methods
    func save(workout: Workouts) {
        do {
            try realm.write {
                realm.add(workout)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        workouts = realm.objects(Workouts.self)
        tableView.reloadData()
    }
    
    //Mark: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let workoutForDeletion = self.workouts?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(workoutForDeletion)
                }
            } catch {
                print("Error deleting workout, \(error)")
            }
        }
    }
    
    //Mark: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
                     let alert = UIAlertController(title: "Add a New Cateogry", message: "", preferredStyle: .alert)
                     let action = UIAlertAction(title: "Add", style: .default) { (action) in
                         let newWorkout = Workouts()
                         newWorkout.name = textField.text!
                         //            newWorkout.colour = UIColor.randomFlat().hexValue()
                         self.save(workout: newWorkout)
                     }
                     
                     alert.addAction(action)
                     alert.addTextField { (field) in
                         textField = field
                         textField.placeholder = "Add a new workout"
                     }
                     present(alert, animated: true, completion: nil)
    }
    
   
    
    //Mark: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSets", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SetsViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedWorkout = workouts?[indexPath.row]
        }
    }
    
    
    
}
