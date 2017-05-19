//
//  ProfileController.swift
//  FlashFitPro
//
//  Created by Sweet Pixel Studios on 11/06/2015.
//  Copyright (c) 2015 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
import Alamofire
import SwiftyUserDefaults
import SwiftSpinner


class ProfileController: UIViewController {

    @IBOutlet weak var btnStartOutlet: UIButton!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    @IBAction func btnBackAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStartOutlet.layer.borderWidth = 1.0
        btnStartOutlet.layer.borderColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 167/255.0, alpha: 1.0).CGColor
        btnStartOutlet.layer.cornerRadius = 9.0
    
        
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func btnStartAction(sender: AnyObject) {
        //var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
        let params: [String : AnyObject?] = ["FirstName": firstNameField.text, "LastName" : lastNameField.text, "Email" : emailField.text, "Address" : addressField.text]
        
        
        
        do {
            let opt = try HTTP.POST("https://flashfit.herokuapp.com/api/register", parameters: params)
            SwiftSpinner.show("Please wait...")
            opt.start { response in
                var swiftyJSON = JSON(response.text!)
                print(swiftyJSON["id"].stringValue)
                
                Defaults["userID"] = swiftyJSON["id"].stringValue
                Defaults["FirstName"] = self.firstNameField.text
                Defaults["LastName"] = self.lastNameField.text
                Defaults["Email"] = self.emailField.text
                Defaults["Address"] = self.addressField.text
                Defaults["isLoggedIn"] = true

                let type : UIUserNotificationType = [.Alert, .Sound]
                let setting = UIUserNotificationSettings(forTypes: type, categories: nil);
                UIApplication.sharedApplication().registerUserNotificationSettings(setting);
                UIApplication.sharedApplication().registerForRemoteNotifications();
                
                SwiftSpinner.hide()
                
                NSOperationQueue.mainQueue().addOperationWithBlock {
//                    self.performSegueWithIdentifier("tabBarSegue", sender: sender)
                    self.dismissViewControllerAnimated(true, completion: nil)
            
                    
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "registrationSuccessful", object: self))
                }
                
            }
        }
        catch  let error {
            print (error)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return false
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
