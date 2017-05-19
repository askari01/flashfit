//
//  AvailabilityTableViewController.swift
//  FlashFitPro
//
//  Created by Syed Askari on 5/9/16.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyUserDefaults


class AvailabilityTableViewController: UITableViewController {
    
    var avail: [[String: Any]] = []
    var slots: Int = 0
    var totalslots: Int = 0
    var starthour: Int = 0
    var check: Int = 0
    var mult:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    private func time(index: Int) -> String {
        let startDate = Defaults.valueForKey("startDate")!
        let endDate = Defaults.valueForKey("endDate")!
        
        let formatter  = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        let startdate = formatter.dateFromString(startDate as! String)
        let enddate = formatter.dateFromString(endDate as! String)
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: startdate!)
        let interval = enddate!.timeIntervalSinceDate(startdate!)
        
        var hour = comp.hour
        var minute = comp.minute
        if (slots < totalslots)
        {
            minute = minute + (15 * mult)
            mult = mult + 1
            if (mult == 5) {
                mult = 0
            }
           
            print(slots)
            if(minute > 59){
                minute = minute - 60
                hour = hour + slots
            }
            print(hour)
            //hour =  hour + slots
            slots = slots + 1
        }
        
        if (check == 0){
        if (hour >= 12){
            
            let time = "\(hour):\(minute) pm"
                avail.insert([
                    "time" : time,
                    "avail" : "",
                    "booked" : 0
                    ], atIndex: index)
            
            
            return ("\(hour):\(minute) pm")
        } else {
            let time = "\(hour):\(minute) am"
            avail.insert([
                "time" : time,
                "avail" : "",
                "booked" : 0
                ], atIndex: index)
            
            return ("\(hour):\(minute) am")
        }
        } else {
            if (hour >= 12){
            
                return ("\(hour):\(minute) pm")
            } else {
            
                return ("\(hour):\(minute) am")
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        totalslots = slot ()
        return totalslots
    }

    private func slot()-> Int {
        let startDate = Defaults.valueForKey("startDate")!

        let formatter  = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        let startdate = formatter.dateFromString(startDate as! String)
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour], fromDate: startdate!)
        let starthour = comp.hour
        totalslots = 19 - starthour
        totalslots = totalslots * 4
        return totalslots
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! TimeTableViewCell
        
        // Configure the cell...
        cell.layer.backgroundColor = UIColor.blackColor().CGColor
        cell.timeLbl.text = time(indexPath.row)
        var availcheck = String(avail[indexPath.row]["avail"]!)
        if (cell.availLbl.text == "Label" || availcheck == "" ){
            cell.availLbl.text = "Tap to set"
        } else {
            cell.availLbl.text = String(avail[indexPath.row]["avail"]!)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! TimeTableViewCell

        cell.layer.backgroundColor = UIColor.blackColor().CGColor
        check = 1
        slots = 0
        mult = 0
            var availcheck = String(avail[indexPath.row]["avail"]!)
        
        if (availcheck == "Available"){
            //cell.availLbl.textColor = UIColor.init(red: 66/255.0, green: 212/255.0, blue: 184/255.0, alpha: 1)
            
            cell.availLbl.text = "Not Available"
            avail[indexPath.row]["avail"] = "Not Available"
            //cell.reloadInputViews()
            
        } else {
            cell.availLbl.textColor = UIColor.lightGrayColor()
            avail[indexPath.row]["avail"] = "Available"
        
            cell.availLbl.text = "Available"
        }
        cell.timeLbl.text = String(avail[indexPath.row]["time"]!)
        cell.contentView.backgroundColor = UIColor.blackColor()
        tableView.reloadData()
        
    }

    
//    //Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//         //Return false if you do not want the specified item to be editable.
//        return true
//    }
 

    /*
     Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
             Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
