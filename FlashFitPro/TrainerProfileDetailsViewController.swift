//
//  TrainerProfileDetailsViewController.swift
//  FlashFitPro
//
//  Created by Syed Askari on 5/14/16.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyUserDefaults

class TrainerProfileDetailsViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fname = (Defaults.valueForKey("trainerProfileFristName")!)
        print(fname)
        var lname = (Defaults.valueForKey("trainerProfileLastName")!)
        print(lname)
        var rate = (Defaults.valueForKey("trainerProfileRate")!)
        
        self.nameLbl.text = (fname as! String)+" "+(lname as! String)
        self.rateLbl.text = "$"+(rate as! String)+"/hr"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkAvailBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("goToCheckAvail", sender: self)
    }

    @IBAction func bookNowBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("goToCheckAvail", sender: self)
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
