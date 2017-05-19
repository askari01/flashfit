//
//  ViewController.swift
//  FlashFitPro
//
//  Created by Sweet Pixel Studios on 11/06/2015.
//  Copyright (c) 2015 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftHTTP
import Alamofire
import SwiftyUserDefaults
import SwiftSpinner
import SWBufferedToast
import ChameleonFramework
import SwiftyJSON


class ViewController: UIViewController, SWBufferedToastDelegate {
    
    
//  var braintree: Braintree!
    

    @IBOutlet weak var btnLoginOutlet: UIButton!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var btnSendCodeOutlet: UIButton!
    @IBOutlet weak var trainerSignupOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        Alamofire.request(.GET, "http://192.168.100.141:3000/test",parameters: nil)
//            .responseJSON { response in
//                print(response)
//        }
//        self.braintree.setReturnURLScheme("com.your-company.Your-App.payments")
        
//        btnSendCodeOutlet.layer.borderWidth = 1.0
//        btnSendCodeOutlet.layer.borderColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 167/255.0, alpha: 1.0).CGColor
//        btnSendCodeOutlet.layer.cornerRadius = 9.0
        
        btnSendCodeOutlet.tag = 1
        
        trainerSignupOutlet.tag = 2
        
//        btnLoginOutlet.layer.borderWidth = 1.0
//        btnLoginOutlet.layer.borderColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 167/255.0, alpha: 1.0).CGColor
//        btnLoginOutlet.layer.cornerRadius = 9.0
        
        btnLoginOutlet.tag = 3
        
        //to-do: if user is already registered than take directly to profile screen. 
        //check if user is trainer or normal user
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        
//        let ectoplasmGreen = 
        
        let toast = SWBufferedToast(loginToastWithTitle: "Login to FlashFit", usernameTitle: "Email", passwordTitle: "Password", doneTitle: "Login or Dismiss", backgroundColour:UIColor.grayColor().colorWithAlphaComponent(0.7) , toastColor: UIColor.init(red: 84/255.0, green: 209/255.0, blue: 182/255.0, alpha: 0.9), animationImageNames: nil, andDelegate: self, onView: self.view)
        
        // UIColor(red: 0.34, green: 0.84, blue: 0.73, alpha: 0.5)
        
        toast.appear()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let loggedIn = Defaults["isLoggedIn"].boolValue
        
        
        if (loggedIn) {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.dismissViewControllerAnimated(false, completion: nil)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func SendCode(sender: AnyObject) {
        
        
        if (phoneNumberField.text!.isEmpty)
        {
            
            let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "Field cannot be empty"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else {
        SwiftSpinner.show("Please wait...")
        
        
        Alamofire.request(.POST, "https://flashfit.herokuapp.com/api/tokenrequest", parameters: ["PhoneNumber": phoneNumberField.text!], encoding: Alamofire.ParameterEncoding.JSON, headers: nil)
            .responseString { response in
                
                
                print(response)
                
                SwiftSpinner.hide()
                
                self.performSegueWithIdentifier("codeSegue", sender: sender)

            }
        }

    }
    

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if (sender?.tag == 2) {
            return true
        }
        else {
            if (phoneNumberField.text!.isEmpty) {
//                let alert = UIAlertView()
//                alert.title = "Alert"
//                alert.message = "Field cannot be empty"
//                alert.addButtonWithTitle("Ok")
//                alert.show()
            
                return false
            }
            else {
                return false
            }
    }
        
    }
    
    
//    SWBufferedToast Delegate methods
    
    func didAttemptLoginWithUsername(username: String!, andPassword password: String!, withToast toast: SWBufferedToast!) {
        
        if(username.isEmpty || password.isEmpty)
        {
            toast.dismiss()
        }
        else {
            Alamofire.request(.POST, "https://flashfit.herokuapp.com/api/authenticate", parameters: ["Email" : username, "password" : password], encoding: ParameterEncoding.JSON, headers: nil)
                .responseJSON { response in
                    //print(response)
                    
                    if let value = response.result.value {
                        //print(response.data)
                        //print("response: \(response)")
                        //print("value: \(value)")
                        let json = JSON(value);
                        
                        //check
                        if (json["success"] == false ) {
                            Defaults["isLoggedIn"] = false
                            Defaults["isTrainer"] = false
                            toast.dismiss()
                            let alert = UIAlertView()
                            alert.title = "Error"
                            alert.message = "Uername or Password is Incorrect"
                            alert.addButtonWithTitle("Ok")
                            alert.show()

                        } else {

                        
//                        if(json["isTrainer"] == true) {
//                            Defaults["isTrainer"] = true
//                        } else {
                            Defaults["isTrainer"] = false
//                        }
                        
                            Defaults["isLoggedIn"] = true
                            Defaults["userID"] = json["id"].stringValue
                            print(json["id"].stringValue)
                            toast.dismiss()
                        
                        //check
                        if (json["success"] == false ) {
                            Defaults["isLoggedIn"] = false
                            Defaults["isTrainer"] = false
                        }
                        
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                
                                self.dismissViewControllerAnimated(true, completion: nil)
                                
                                
                                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "registrationSuccessful", object: self))
                            }
                            
                            let type : UIUserNotificationType = [.Alert, .Sound]
                            let setting = UIUserNotificationSettings(forTypes: type, categories: nil);
                            UIApplication.sharedApplication().registerUserNotificationSettings(setting);
                            UIApplication.sharedApplication().registerForRemoteNotifications();
                        }
                    }
                    
                    }
            }
        }

    
    
    func didTapActionButtonWithToast(toast: SWBufferedToast!) {
        print("button tapped")
    }
    
    func didDismissToastView(toast: SWBufferedToast!) {
        print("dismissed")
    }
    



}
