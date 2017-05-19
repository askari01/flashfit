//
//  TrainerProfileController.swift
//  FlashFitPro
//
//  Created by Sweet Pixel Studios on 03/07/2015.
//  Copyright (c) 2015 FlashFitPro. All rights reserved.
//

import UIKit
import ALCameraViewController
import SCLAlertView
import Alamofire

class TrainerProfileController: UIViewController
 {
    @IBOutlet weak var fnameField: UITextField!
    
    @IBOutlet weak var lnameField: UITextField!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var contactNoField: UITextField!
    @IBAction func accessRequestAction(sender: AnyObject) {
        
        let url = "https://flashfit.herokuapp.com/api/trainer/request"
        
        Alamofire.request(.POST, url, parameters: ["firstname": fnameField.text!, "lastname" : lnameField.text!, "email": emailField.text!, "phone":contactNoField.text!], encoding: ParameterEncoding.JSON, headers: nil)
            .responseString {
                response in
                
                print(response.result)
        }
    
    }
    


    @IBAction func backDismissThis(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet weak var certificateOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        picker.delegate = self
        
        certificateOutlet.layer.borderWidth = 1.0
        certificateOutlet.layer.borderColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 167/255.0, alpha: 1.0).CGColor
        certificateOutlet.layer.cornerRadius = 9.0
        certificateOutlet.tag = 1

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
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
