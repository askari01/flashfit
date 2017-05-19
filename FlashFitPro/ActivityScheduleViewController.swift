//
//  ActivityScheduleViewController.swift
//  FlashFitPro
//
//  Created by Syed Askari on 5/7/16.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ActivityScheduleViewController: UIViewController {

    @IBOutlet weak var daysSegment: UISegmentedControl!

    @IBAction func dismissBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func dismissBtnAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func daysSegmentAction(sender: AnyObject) {
        print(self.daysSegment.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let startDate = Defaults.valueForKey("startDate")!
        let endDate = Defaults.valueForKey("endDate")!
        
        let end = days(startDate as! String, endDate: endDate as! String)
        let start = calendar(startDate as! String)
        
        self.daysSegment.removeAllSegments()
        
        var day: String = ""
        if end>0 && end<8 {
            
            var check = start
            for index in 1...end {
                
                if ((check+index-1) <= 7){
                    var check1 = check+index-1
                    switch check1 {
                    case 1:
                        day = "Sun"
                    case 2:
                        day = "Mon"
                    case 3:
                        day = "Tue"
                    case 4:
                        day = "Wed"
                    case 5:
                        day = "Thu"
                    case 6:
                        day = "Fri"
                    case 7:
                        day = "Sat"
                        check = 0
                    default:
                        print("Error fetching days")
                        print(start)
                        day = "Day"
                    }
                } else {check = 0}
                self.daysSegment.insertSegmentWithTitle(day, atIndex: index-1, animated: true)
            }
        } else {
            self.daysSegment.insertSegmentWithTitle(day, atIndex: 0, animated: true)
        }
        self.daysSegment.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func calendar(date: String) -> Int{
        
        let formatter  = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        let todayDate = formatter.dateFromString(date)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.component(.Weekday, fromDate: todayDate)
        let weekDay = myComponents
        return weekDay
    }
    
    private func days(startDate: String, endDate: String) -> Int {
        let formatter  = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        let start = formatter.dateFromString(startDate)!
        let end = formatter.dateFromString(endDate)!
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components(.Day, fromDate: start, toDate: end, options: [])
        
        return components.day
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
