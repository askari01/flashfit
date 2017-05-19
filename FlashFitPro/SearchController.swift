//
//  SearchController.swift
//  FlashFitPro
//
//  Created by Sweet Pixel Studios on 04/07/2015.
//  Copyright (c) 2015 FlashFitPro. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar(frame: CGRectMake(28, 0, (self.navigationController?.navigationBar.frame.width)! - 33, 44))
        //searchBar.barStyle = UIBarStyle.Black
        //searchBar.translucent = true
        searchBar.placeholder = "Search"
        searchBar.layer.masksToBounds = true
        searchBar.clipsToBounds = true
        searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
        //searchBar.showsCancelButton = true
        //self.navigationController?.navigationBar.addSubview(searchBar)
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.addSubview(searchBar)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        searchBar.endEditing(true)
        searchBar.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell: UITableViewCell!
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        return cell!
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
