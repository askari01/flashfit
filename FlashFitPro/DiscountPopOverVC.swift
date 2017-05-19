//
//  DiscountPopOverVC.swift
//  FlashFitPro
//
//  Created by User on 4/12/16.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyUserDefaults


class DiscountPopOverVC: UIViewController, UIPopoverControllerDelegate {

    @IBOutlet weak var discountValue: UITextField!
    @IBOutlet weak var discountBtn: UIButton!
    
    @IBAction func discountBtn(sender: AnyObject) {
        if (discountValue.text != ""){
            Defaults["discount"] = discountValue.text
            //var disc = Int(discountValue.text!)!
            //Defaults.setInteger(disc, forKey: "discount")
            print("\(Defaults.integerForKey("discount"))")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discountBtn.layer.cornerRadius = 5
        
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
