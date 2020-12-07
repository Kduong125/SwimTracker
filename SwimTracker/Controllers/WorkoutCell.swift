//
//  WorkoutCellViewController.swift
//  SwimTracker
//
//  Created by Kenneth Duong on 11/19/20.
//  Copyright © 2020 Kenneth Duong. All rights reserved.
//

import UIKit

protocol workoutTableView {
   
}

class WorkoutCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yardageLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var cellDelegate: workoutTableView?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
