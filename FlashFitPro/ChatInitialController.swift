//
//  ChatInitialController.swift
//  FlashFitPro
//
//  Created by Sweet Pixel Studios on 26/06/2015.
//  Copyright (c) 2015 FlashFitPro. All rights reserved.
//

import UIKit

class ChatInitialController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        tableViewOutlet.tableFooterView = UIView(frame: CGRectZero)
       
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.performSegueWithIdentifier("goToChatThread", sender: self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch (indexPath.row){
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("cell0")!
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("cell1")!
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("cell1")!
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }

        return cell
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var initialCount = 0
        let pageSize = 50
        
        var dataSource: FakeDataSource!
        if segue.identifier == "goToChatThread" {
            dataSource = FakeDataSource(messages: TutorialMessageFactory.createMessages().map { $0 }, pageSize: pageSize)
        } else {
            assert(false, "segue not handled!")
        }
        
        let chatController = segue.destinationViewController as! DemoChatViewController
        if dataSource == nil {
            dataSource = FakeDataSource(count: initialCount, pageSize: pageSize)
        }
        chatController.dataSource = dataSource
        chatController.messageSender = dataSource.messageSender
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.0
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
