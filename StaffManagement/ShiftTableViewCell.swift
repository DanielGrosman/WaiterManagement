//
//  ShiftTableViewCell.swift
//  StaffManagement
//
//  Created by Daniel Grosman on 2018-01-28.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftTableViewCell: UITableViewCell {


    @IBOutlet weak var shiftDateLabel: UILabel!
    @IBOutlet weak var shiftMonthLabel: UILabel!
    @IBOutlet weak var shiftYearLabel: UILabel!
    @IBOutlet weak var shiftTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
