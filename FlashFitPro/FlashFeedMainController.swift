//
//  FlashFeedMainController.swift
//  FlashFitPro
//
//  Created by Sweet Pixel Studios on 19/06/2015.
//  Copyright (c) 2015 FlashFitPro. All rights reserved.
//

import UIKit

class FlashFeedMainController: UIViewController {

    @IBOutlet weak var fitProBttn: UIButton!
    @IBOutlet weak var facilityBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fitProBttn.layer.borderWidth = 1.5
        fitProBttn.layer.borderColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 167/255.0, alpha: 1.0).CGColor
        fitProBttn.layer.cornerRadius = 9.0
        
//        facilityBttn.layer.borderWidth = 1.5
//        facilityBttn.layer.borderColor = UIColor(red: 72/255.0, green: 201/255.0, blue: 167/255.0, alpha: 1.0).CGColor
//        facilityBttn.layer.cornerRadius = 9.0
        
        
        // Push notification registration. We need to send the user._id along the deviceToken
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
