//
//  AddSaleTimeVC.swift
//  FlashFitPro
//
//  Created by Pixel Mac on 05/04/2016.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import SWBufferedToast
import SwiftyUserDefaults
import Alamofire
import SwiftSpinner

class AddSaleTimeVC: UITableViewController, UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var currentDateLbl: UILabel!
    @IBOutlet weak var currentDateCell: UITableViewCell!
    
    @IBOutlet weak var endDateLbl: UILabel!
    @IBOutlet weak var endDateCell: UITableViewCell!
    
    
    @IBOutlet weak var discountCell: UITableViewCell!
    
    @IBAction func confirmBtn(sender: AnyObject) {
        SwiftSpinner.show("Please Wait...")
        print("confirm")
        print("\(Defaults.integerForKey("discount"))")
        print("\(Defaults.valueForKey("startDate"))")
        print("\(Defaults.valueForKey("endDate"))")
        print("\(Defaults.valueForKey("userID"))")
        
        
        Alamofire.request(.POST, "https://flashfit.herokuapp.com/api/flashsale", parameters: ["userid": Defaults.valueForKey("userID")!, "discount": Defaults.integerForKey("discount"), "endDate": Defaults.valueForKey("endDate")!, "startDate": Defaults.valueForKey("startDate")!], encoding: Alamofire.ParameterEncoding.JSON, headers: nil).responseJSON {
            response in
            if (response.response?.statusCode == 200) {
                SwiftSpinner.hide()
                let toast = SWBufferedToast(plainToastWithTitle: "Done", subtitle: "Successfuly Created", actionButtonText: "OK", backgroundColor: UIColor.grayColor().colorWithAlphaComponent(0.7), toastColor: UIColor.init(red: 84/255.0, green: 209/255.0, blue: 182/255.0, alpha: 0.9), animationImageNames: nil, andDelegate: self, onView: self.view)
                toast.appear()
            } else {
                print("error posting")
                SwiftSpinner.hide()
                let toast = SWBufferedToast(noticeToastWithTitle: "Error", subtitle: "Something Went Wrong", timeToDisplay: 5, backgroundColour: UIColor.grayColor().colorWithAlphaComponent(0.7), toastColor: UIColor.redColor() , animationImageNames: nil, onView: self.view)
                toast.appear()
            }
        }
        //flatGreenColor().colorWithAlphaComponent(0.9)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }

    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        print("popover closed")
        if (Defaults.valueForKey("startDate") != nil){
            currentDateLbl.text = "\(Defaults.valueForKey("startDate")!)"
        }
        if (Defaults.valueForKey("endDate") != nil){
            endDateLbl.text = "\(Defaults.valueForKey("endDate")!)"
        }
        
    }
    
    
    func discount(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("goToDiscount", sender: sender)
    }
    
    func startDate(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("goToStartDate", sender: sender)
    }
    
    func endDate(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("goToEndDate", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
          if segue.identifier == "goToDiscount" {
            if let controller = segue.destinationViewController as? UIViewController {
                controller.popoverPresentationController!.delegate = self
                controller.preferredContentSize = CGSize(width: 320, height: 140)
                //self.presentViewController(, animated: true, completion: nil)
            }
        }
          if segue.identifier == "goToStartDate" {
            if let controller1 = segue.destinationViewController as? UIViewController {
                controller1.popoverPresentationController!.delegate = self
                controller1.preferredContentSize = CGSize(width: 335, height: 200)
                //self.presentViewController(, animated: true, completion: nil)
                }
            }
        if segue.identifier == "goToEndDate" {
            if let controller2 = segue.destinationViewController as? UIViewController {
                controller2.popoverPresentationController!.delegate = self
                controller2.preferredContentSize = CGSize(width: 320, height: 200)
                //self.presentViewController(, animated: true, completion: nil)
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func didTapActionButtonWithToast(toast: SWBufferedToast) {
        toast.dismiss()
        self.dismissViewControllerAnimated(true, completion: nil)    }
    
    func didDismissToastView(toast: SWBufferedToast!) {
        self.dismissViewControllerAnimated(true, completion: nil)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let currentDateTime = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        let dateNtime = formatter.stringFromDate(currentDateTime)
        currentDateLbl.text = "\(dateNtime)"
        endDateLbl.text = "\(dateNtime)"
        
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(discount))
        tap.numberOfTapsRequired = 1
        discountCell.addGestureRecognizer(tap)
        
        
        let tap1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startDate))
        tap1.numberOfTapsRequired = 1
        currentDateCell.addGestureRecognizer(tap1)
        
        
        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endDate))
        tap2.numberOfTapsRequired = 1
        endDateCell.addGestureRecognizer(tap2)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
