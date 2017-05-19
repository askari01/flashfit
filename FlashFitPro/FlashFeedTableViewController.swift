//
//  FlashFeedTableViewController.swift
//  FlashFitPro
//
//  Created by Ali Raza on 11/30/15.
//  Copyright © 2015 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Alamofire
import SwiftyJSON
import SwiftSpinner

class FlashFeedTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet var tabelView: UITableView!
    
    var row = 0
    var json: JSON = []

    override func viewDidLoad() {
        SwiftSpinner.show("Loading Data...")
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToEdit))
        tap.numberOfTapsRequired = 1
        
        Alamofire.request(.GET, "https://flashfit.herokuapp.com/api/flashsale", parameters: nil, encoding: Alamofire.ParameterEncoding.JSON, headers: nil).responseJSON {
            response in
            if (response.response?.statusCode == 200){
                //print(response)
                if let value = response.result.value {
                    self.json = JSON(value)
                    //print(self.json)
                    self.row = self.json.count
                    self.tabelView.reloadData()
                    SwiftSpinner.hide()
                }
            }
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        Alamofire.request(.GET, "https://flashfit.herokuapp.com/api/flashsale", parameters: nil, encoding: Alamofire.ParameterEncoding.JSON, headers: nil).responseJSON {
            response in
            if (response.response?.statusCode == 200){
                //print(response)
                if let value = response.result.value {
                    let json = JSON(value)
                    //print(json)
                    self.row = json.count
                    //print(self.row)
                    //print(self.json[0]["facilityPictures"])
                    self.tabelView.reloadData()
                }
            }
        }
    }
    
    func goToEdit(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("goToEdit", sender: self)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.row
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 180.0;//Choose your custom row height
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(Defaults["isTrainer"].boolValue == false) {
            
            Defaults["trainerProfileFristName"] = String(json[indexPath.row]["userTableId"]["firstName"])
            Defaults["trainerProfileLastName"] = String(json[indexPath.row]["userTableId"]["lastName"])
            Defaults["trainerProfileLastName"] = String(json[indexPath.row]["userTableId"]["lastName"])
            Defaults["trainerProfilePic"] = String(json[indexPath.row]["facilityPictures"])
            Defaults["trainerProfileRate"] = String(json[indexPath.row]["hourlyRate"])
            
            
            self.performSegueWithIdentifier("goToProfile", sender: self)
        } else { print("can't go further, logged in as trainer: \(Defaults["isTrainer"].boolValue) ")}
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:indexPath) as! FlashFeedTableViewCell
//        var rate = self.json[indexPath.row]["hourlyRate"].int!
//        cell.nameLabel.text = self.json[indexPath.row]["userTableId"]["firstName"].string!+" "+self.json[indexPath.row]["userTableId"]["lastName"].string!
//        cell.rateLabel.text = "$\(String(rate))"
//        if (self.json[indexPath.row]["FlashSales"][0]["discount"].string != nil) {
//            cell.discountLabel.text = "\(self.json[indexPath.row]["FlashSales"][0]["discount"].string!)% off"
//        } else {
//            cell.discountLabel.text = ""
//            cell.discountLabel.backgroundColor = UIColor.clearColor()
//        }
//        cell.distanceLabel.text = "100 m"
//        let url = NSURL(string: self.json[indexPath.row]["facilityPictures"].string!)
//        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//        cell.bgImageView.image = UIImage(data: data!)
//        //cell.bgImageView.image = UIImage(named: "flashfeedcontent-2")
//        
        
        return cell
    }
    
}
