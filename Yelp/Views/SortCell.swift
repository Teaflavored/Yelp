//
//  SortCell.swift
//  Yelp
//
//  Created by Auster Chen on 9/24/17.
//  Copyright © 2017 Auster Chen. All rights reserved.
//

import UIKit

class SortCell: UITableViewCell {

    @IBOutlet weak var sortLabel: UILabel!
    var sortValue: YelpSortMode?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
