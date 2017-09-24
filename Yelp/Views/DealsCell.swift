//
//  DealsCell.swift
//  Yelp
//
//  Created by Auster Chen on 9/23/17.
//  Copyright © 2017 Auster Chen. All rights reserved.
//

import UIKit

protocol DealsCellDelegate: class {
    func dealsSwitchCellDidToggle(cell: DealsCell, newValue: Bool)
}

class DealsCell: UITableViewCell {

    @IBOutlet weak var dealSwitch: UISwitch!

    weak var delegate: DealsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onToggleDealsSwitch(_ sender: UISwitch) {
        delegate?.dealsSwitchCellDidToggle(cell: self, newValue: dealSwitch.isOn)
    }
}
