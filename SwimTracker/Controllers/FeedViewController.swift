//
//  MenuViewController.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/19/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class FeedViewController: UITableViewController {
    
    let realm = try! Realm()
    var workouts: Results<Workouts>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")}
        navBar.backgroundColor = UIColor(named: BrandColors.lightBlue)
        navBar.prefersLargeTitles = true
        tableView.separatorStyle = .none
        loadWorkouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    
    
    //Mark: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! WorkoutCell
//        cell.contentView.layer.cornerRadius = cell.contentView.frame.height / 2
        cell.titleLabel.text? = workouts?[indexPath.row].name ?? "No Workouts added yet"
      
        //        cell.dateLabel.text =
        //        if let workout = workouts?[indexPath.row] {
        //            guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
        //            cell.backgroundColor = categoryColour
        //            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        //        }
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    func save(workout: Workouts) {
        do {
            try realm.write {
                realm.add(workout)
            }
        } catch {
            print("Error saving workout \(error)")
        }
        tableView.reloadData()
    }
    
    func loadWorkouts() {
        workouts = realm.objects(Workouts.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data from Swipe
    func updateModel(at indexPath: IndexPath) {
        if let workoutForDeletion = self.workouts?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(workoutForDeletion)
                    loadWorkouts()
                }
            } catch {
                print("Error deleting workout, \(error)")
            }
        }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a New Workout", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newWorkout = Workouts()
            //                                 newWorkout.name = textField.text!
            self.save(workout: newWorkout)
            self.performSegue(withIdentifier: "goToSets", sender: self)
        }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //Mark: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSets", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
        print("tableview was pressed")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SetsViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedWorkout = workouts?[indexPath.row]
        }
    }
}

//extension FeedViewController: workoutTableView {
//    func optionsPressed(index: Int) {
//        print("options was pressed")
//        let deleteAlert = UIAlertController(title: "Delete a workout", message: "", preferredStyle: UIAlertController.Style.actionSheet)
//        
//        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action: UIAlertAction) in
//
//
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        deleteAlert.addAction(deleteAction)
//        deleteAlert.addAction(cancelAction)
//        self.present(deleteAlert, animated: true, completion: nil)
//    }
//
//}
