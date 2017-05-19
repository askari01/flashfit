//
//  FlashSaleTrainerTableViewController.swift
//  FlashFitPro
//
//  Created by Ali Raza on 2/9/16.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftyUserDefaults

class FlashSaleTrainerTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var availabilitySchedule: UITableViewCell!
    @IBOutlet weak var uploadSaleBtn: UIBarButtonItem!
    
    @IBOutlet weak var signOutBtn: UILabel!
    
    
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userRegistered), name: "registrationSuccessful", object: nil)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signOut))
        tap.numberOfTapsRequired = 1
        signOutBtn?.addGestureRecognizer(tap)
        
        let availTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(availabilitySch))
        availTap.numberOfTapsRequired = 1
        availabilitySchedule.addGestureRecognizer(availTap)
        
        print(Defaults["isTrainer"].boolValue)
        if(Defaults["isTrainer"].boolValue == false) {
            print(Defaults["isTrainer"].boolValue)
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }
    
    func availabilitySch(sender: UITapGestureRecognizer){
        self.performSegueWithIdentifier("goToAvailabilitySchedule", sender: self)
    }
    
    
    func userRegistered(sender: NSNotification) {
        print("user registered")
    }
    
    func signOut(sender: UITapGestureRecognizer){
        print("hello")
        Defaults["isLoggedIn"] = false
        Defaults["isTrainer"] = false
        Defaults["userID"] = ""
        Defaults["FirstName"] = ""
        Defaults["LastName"] = ""
        Defaults["Email"] = ""
        Defaults["Address"] = ""

        
        print(NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys)
        
        self.performSegueWithIdentifier("goToSignin", sender: self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("\(Defaults["FirstName"].stringValue)")
        
        nameLabel.text = "Johnny Bravo"
        emailLabel.text = "johnnybravo@abc.com"
        
        //nameLabel?.text = String(format: "%@ %@", Defaults["FirstName"].stringValue, Defaults["LastName"].stringValue)
        //emailLabel?.text = Defaults["Email"].stringValue
        
        
    }

    @IBAction func creatFlashShale(sender: AnyObject) {
        
        let userID = Defaults["userID"].stringValue
        print(userID)
        
        let startDate = NSDate().description
        let endDate = NSDate().description
        
        print(startDate)
        print(endDate)

        
        let discount = "10"
        
        print(discount)
        
        Alamofire.request(.POST, "https://flashfit.herokuapp.com/api/saveflashsale", parameters:
            ["userid" : userID, "discount" : discount, "startDate":startDate, "endDate" : endDate], encoding: ParameterEncoding.JSON)
            .responseJSON{ response in
                let json = JSON(response.result.value!)
                
                if (json["status"].boolValue == true) {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else {
                    print("an error occured");
                }
                print(response.description)
        }
        
        
        
        
        
    }
}
