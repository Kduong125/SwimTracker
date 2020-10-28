//
//  Sets.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 10/23/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import Foundation
import RealmSwift

class Sets: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var dateCreated: Date?
    var parentSet = LinkingObjects(fromType: Workouts.self, property: "sets")
}
