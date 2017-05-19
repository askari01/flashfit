//
//  MainTabBarControllerViewController.swift
//  FlashFitPro
//
//  Created by Ali Raza on 11/9/15.
//  Copyright © 2015 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
//import ViewController

class MainTabBarControllerViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userRegistered", name: "registrationSuccessful", object: nil)
        // Do any additional setup after loading the view.
        
   
    
    }
    
    
    func userRegistered() {
        print("I got the registration notification")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        let loggedIn = Defaults["isLoggedIn"].boolValue
        
        if (!loggedIn) {
            showLoginScreen(true)
        }
        
    }
    
    
    func showLoginScreen(animated: Bool){
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("signInVC") as! ViewController
        
        
        //        var rootViewController =
        
        
       self.presentViewController(viewController, animated: true, completion: nil)
        
        
        
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
