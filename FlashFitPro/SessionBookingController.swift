//
//  SessionBookingController.swift
//  FlashFitPro
//
//  Created by Sweet Pixel Studios on 04/07/2015.
//  Copyright (c) 2015 FlashFitPro. All rights reserved.
//

import UIKit

class SessionBookingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func crossBttnTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
