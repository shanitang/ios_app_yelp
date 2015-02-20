//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Yeu-Shuan Tang on 2/14/15.
//  Copyright (c) 2015 Yeu-Shuan Tang. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func dealSwitchChange(on: Bool)
    func sortByChange(sort: Int)
    func distanceChange(distance: Int)
    func search()
}

class SettingsViewController: UITableViewController {
    
    weak var delegate: FilterDelegate?

    @IBOutlet var sort1: SettingsViewCell!
    @IBOutlet var sort2: SettingsViewCell!
    @IBOutlet var sort3: SettingsViewCell!
    @IBOutlet var sort4: SettingsViewCell!
    
    @IBOutlet var distance1: SettingsViewCell!
    @IBOutlet var distance2: SettingsViewCell!
    @IBOutlet var distance3: SettingsViewCell!
    @IBOutlet var distance4: SettingsViewCell!
    
    @IBOutlet var dealTable: UITableViewCell!
    @IBOutlet var applyButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    @IBOutlet var dealSwitch: UISwitch!
    
    var changed: Bool!
    var sort: Int!
    var distance: Int!
    
    var rowsInSection: [Int] = [1,4,4]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyButton.title = "Search"
        applyButton.target = self
        applyButton.action = "onSearchButton:"
        
        
        cancelButton.target = self
        cancelButton.action = "onCancelButton:"
        
        dealSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        changed = false
        sort = 0
        distance = 0
        
        dealSwitch.on =  NSUserDefaults.standardUserDefaults().boolForKey("switchState")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1{
            delegate?.distanceChange(indexPath.row)
//            self.sort = indexPath.row
            
        }else if indexPath.section == 2{
            delegate?.sortByChange(indexPath.row)
//            self.distance = indexPath.row
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return rowsInSection[section]
    }
    
    func onSearchButton(sender: UIBarButtonItem){
        delegate?.search();
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func onCancelButton(sender: UIBarButtonItem){
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func stateChanged(sender: UISwitch){
        NSUserDefaults.standardUserDefaults().setBool(dealSwitch.on, forKey: "switchState")
        delegate?.dealSwitchChange(self.dealSwitch.on)
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

//            var vc = segue.destinationViewController as YelpViewController
//            vc.deal = self.dealSwitch.on
//            vc.sort_by = self.sort
//            vc.distance_match = self.distance
        
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }*/
    
}
