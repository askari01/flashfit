//
//  EndDateViewController.swift
//  FlashFitPro
//
//  Created by Pixel Mac on 13/04/2016.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class EndDateViewController: UIViewController {

    
    @IBOutlet weak var endDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endDate.addTarget(self, action: #selector(datePickerChanged), forControlEvents: UIControlEvents.ValueChanged)
        self.endDate.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        self.endDate.datePickerMode = .DateAndTime
        endDate.sendAction(#selector(setHighlightsToday), to: nil, forEvent: nil)
        let date = NSDate()
        endDate.setDate(date, animated: false)
        self.view.layer.borderWidth = 0.5
        self.view.layer.borderColor = UIColor.lightGrayColor().CGColor
        // Do any additional setup after loading the view.
    }
    
    func setHighlightsToday(sender: UIDatePicker) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        var endDate = dateFormatter.stringFromDate(datePicker.date)
        print(endDate)
        if (endDate != ""){
            Defaults["endDate"] = String(endDate)
            //Defaults.setValue(strDate, forKey: "endDate")
            print("\(Defaults.valueForKey("endDate"))")
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

}
