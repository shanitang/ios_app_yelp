//
//  BusinessViewCell.swift
//  Yelp
//
//  Created by Yeu-Shuan Tang on 2/10/15.
//  Copyright (c) 2015 Yeu-Shuan Tang. All rights reserved.
//

import UIKit
import CoreLocation

class BusinessViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var bussinessAddress: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var categoriesList: UILabel!
    
//    var business: Business = Business()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func businessesWithDictoinaries(businessDictionary: NSDictionary){
        
        var imageUrl = businessDictionary["image_url"] as String
        var name = businessDictionary["name"] as NSString
        var ratingImagerUrl = businessDictionary["rating_img_url"] as String
        var numReview = businessDictionary["review_count"] as NSInteger
        
        var location = businessDictionary["location"] as NSDictionary
        var locationArray = location["display_address"] as NSArray
        var address = (locationArray[0] as String) + ", " + (locationArray[1] as String)
        var categories = businessDictionary["categories"] as [[String]]
        
        var o = CLLocation.init(latitude: 37.782193,longitude: -122.410254)
        
        var l = location["coordinate"] as NSDictionary
        var s = CLLocation.init(latitude: l["latitude"] as Double,longitude: l["longitude"] as Double)

        var distance = o.distanceFromLocation(s) * 0.000621371
        
        self.photo.setImageWithURL(NSURL(string: imageUrl))
        self.businessName.text = name
        self.rating.setImageWithURL(NSURL(string: ratingImagerUrl))
        self.milesLabel.text = String(format: "%.2f", distance) + " mi"
        self.bussinessAddress.text = address
        self.reviews.text = String(numReview)
    
        for (idx, categories) in enumerate(categories){
            if(idx == 0){
                self.categoriesList.text = categories[0]
            }else{
                self.categoriesList.text = self.categoriesList.text! + ", " + categories[0]
            }
        }

    }

}
