//
//  YelpViewController.swift
//  Yelp
//
//  Created by Yeu-Shuan Tang on 2/10/15.
//  Copyright (c) 2015 Yeu-Shuan Tang. All rights reserved.
//

import UIKit

class YelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate{

    @IBOutlet weak var businessTable: UITableView!
    lazy var search: UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
    @IBOutlet weak var filterButton: UIButton!
    
    var client: YelpClient!

    let yelpConsumerKey = "N1nFPwkuEcJ_d--nWfCpDw"
    let yelpConsumerSecret = "EIaKaV4ITC9FZ5ycxcyh6cxHynY"
    let yelpToken = "VHY9ITegMAxVorPBjaNbj0dgy1Hy-ANN"
    let yelpTokenSecret = "sC5n9iiKwCEo4dsMw9JWkGc91_o"
    
    var businessesDictionary : [NSDictionary]! = []
    var filteredBusinesses = [NSDictionary]()
    
    var is_searching: Bool!
    
    var deal: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessTable.dataSource = self
        businessTable.delegate = self
        
        search.delegate = self
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Resturant", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.businessesDictionary = response["businesses"] as [NSDictionary]
            self.businessTable.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        businessTable.rowHeight = UITableViewAutomaticDimension
        ///???
        businessTable.estimatedRowHeight = 50
    
        is_searching = false
        search.placeholder = "Search"
        navigationItem.titleView = search
        
        if deal == true{
            searchForDeal()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if is_searching == true{
            return filteredBusinesses.count
        }else{
            return businessesDictionary.count
        }
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = businessTable.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessViewCell
        
        var business: NSDictionary
        
        if is_searching == true{
            business = self.filteredBusinesses[indexPath.row]
        }else{
            business = self.businessesDictionary[indexPath.row]
        }
        cell.businessesWithDictoinaries(business)
        
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text.isEmpty{
            is_searching = false
            businessTable.reloadData()
        } else {
//            println(" search text %@ ",searchBar.text as NSString)
            is_searching = true
            filteredBusinesses.removeAll(keepCapacity: false)
            for (idx, businessesDictionary) in enumerate(self.businessesDictionary){
                var cat = businessesDictionary["categories"] as [[String]]
                
                for(i , category) in enumerate(cat){
                    var currentCat = category[0]
                    
                    if currentCat.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                        filteredBusinesses.append(businessesDictionary)
                        break
                    }
                }
            }
            businessTable.reloadData()
        }

    }
    
    func searchForDeal() {
       
        filteredBusinesses.removeAll(keepCapacity: false)
        is_searching = true
        for (idx, businessesDictionary) in enumerate(self.businessesDictionary){
            var d = businessesDictionary["deals"] as [String]
            if d.count > 0 {
                filteredBusinesses.append(businessesDictionary)
            }
        }
        businessTable.reloadData()
    }

    

      /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
