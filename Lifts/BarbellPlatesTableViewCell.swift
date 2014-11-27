//
//  BarbellPlatesTableViewCell.swift
//  Lifts
//
//  Created by Brian Huynh on 8/16/14.
//  Copyright (c) 2014 Brian Huynh. All rights reserved.
//

import UIKit

class BarbellPlate: UITableViewCell {
    
    @IBOutlet weak var plateCategory: UILabel!
    @IBOutlet weak var plateQty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
