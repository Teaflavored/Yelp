//
//  CategoryCell.swift
//  Yelp
//
//  Created by Auster Chen on 9/24/17.
//  Copyright © 2017 Auster Chen. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate: class {
    func onToggleCategorySwitch(categoryCell: CategoryCell, newValue: Bool)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    weak var delegate: CategoryCellDelegate?
    var categoryCode: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onToggleSwitch(_ sender: UISwitch) {
        delegate?.onToggleCategorySwitch(categoryCell: self, newValue: categorySwitch.isOn)
    }
}
