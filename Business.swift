//
//  Bussiness.swift
//  Yelp
//
//  Created by Yeu-Shuan Tang on 2/10/15.
//  Copyright (c) 2015 Yeu-Shuan Tang. All rights reserved.
//

import UIKit

class Business: NSObject {

    var imageUrl : NSString!
    var name : NSString!
    var ratingImagerUrl : NSString!
    var numReview : NSInteger!
    var address : NSString!
    var categories : NSArray!
    var distance : CGFloat!
    
    func businessesWithDictoinaries(businessDictionary: NSDictionary){

        self.imageUrl = businessDictionary["image_url"] as String
        self.name = businessDictionary["name"] as NSString
        self.ratingImagerUrl = businessDictionary["rating_img_url"] as String
        self.numReview = businessDictionary["review_count"] as NSInteger
        
        var location = businessDictionary["location"] as NSDictionary
        self.address = location["address"] as NSString

        self.categories = businessDictionary["categories"] as NSArray
        //        self.distance = distance
    }

}
