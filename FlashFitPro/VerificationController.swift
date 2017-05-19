//
//  VerificationController.swift
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

class VerificationController: UIViewController {

    
    @IBOutlet weak var btnLoginOutlet: UIButton!
    @IBOutlet weak var verificationCodeField: UITextField!
    
    @IBAction func btnBackAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoginOutlet.layer.borderWidth = 1.0
        btnLoginOutlet.layer.borderColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 167/255.0, alpha: 1.0).CGColor
        btnLoginOutlet.layer.cornerRadius = 9.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
//        print("i have appeared")
        
        let loggedIn = Defaults["isLoggedIn"].boolValue
        
        if (loggedIn) {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.dismissViewControllerAnimated(false, completion: nil)
            }

        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnLoginAction(sender: AnyObject) {
//        var request = HTTPTask()
        //we have to add the explicit type, else the wrong type is inferred. See the vluxe.io article for more info.
//        let params = ["Code": verificationCodeField.text]
        
        SwiftSpinner.show("Please wait...")
        Alamofire.request(.POST, "https://flashfit.herokuapp.com/api/verifytoken", parameters: ["Code": verificationCodeField.text!], encoding: Alamofire.ParameterEncoding.JSON, headers: nil)
            .responseString { response in
                print(response)
                SwiftSpinner.hide()
                self.performSegueWithIdentifier("profileSegue", sender: sender)
        }
        


    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }

}
