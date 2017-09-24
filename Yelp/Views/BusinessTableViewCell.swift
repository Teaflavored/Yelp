//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Auster Chen on 9/19/17.
//  Copyright © 2017 Auster Chen. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var resturantPhotoImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!

    fileprivate var business: Business?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateWithBusiness(_ business: Business?) -> Void {
        if let restaurantPhotoUrl = business?.imageURL {
            resturantPhotoImageView.setImageWith(restaurantPhotoUrl)
        }

        if let restaurantName = business?.name {
            restaurantNameLabel.text = restaurantName
        }

        if let distance = business?.distance {
            distanceLabel.text = distance
        }

        if let address = business?.address {
            addressLabel.text = address
        }

        if let ratingImageUrl = business?.ratingImageURL {
            ratingImageView.setImageWith(ratingImageUrl)
        }

        if let categories = business?.categories {
            categoriesLabel.text = categories
        }

        if let numberOfReviews = business?.reviewCount {
            numberOfReviewsLabel.text = "\(numberOfReviews) Reviews"
        }
    }
}
