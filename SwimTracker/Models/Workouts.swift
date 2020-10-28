//
//  Workout.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/23/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import Foundation
import RealmSwift
 
class Workouts: Object {
    @objc dynamic var name: String = ""
//    @objc dynamic var yardage: Int = 0
//    @objc dynamic var duration: Int = 0
    let sets = List<Sets>()
}

