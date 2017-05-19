//
//  ConversationVC.swift
//  FlashFitPro
//
//  Created by User on 4/9/16.
//  Copyright © 2016 FlashFitPro. All rights reserved.
//

import UIKit
import Parse


var userName = "flower@gmail.com"
var otherName = "sky@gmail.com"

class ConversationVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UITextViewDelegate {

    @IBOutlet weak var messageTxtView: UITextView!
    
    @IBOutlet weak var resultScrollView: UIScrollView!
    
    @IBOutlet weak var frameMessageView: UIView!
    
    @IBOutlet weak var lineLbl: UILabel!
    
    
    let mLbl = UILabel(frame: CGRectMake(5, 8, 200, 20))

    
    var messageX:CGFloat = 37.0
    var messageY:CGFloat = 26.0
    
    
    var frameX:CGFloat = 32.0
    var frameY:CGFloat = 21.0
    
    
    var messagArray = [String]()
    var senderArray = [String]()
    
    var scrollViewOriginalY:CGFloat = 0
    var frameMessageOriginalY:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewOriginalY = self.resultScrollView.frame.origin.y
        frameMessageOriginalY = self.frameMessageView.frame.origin.y
        
        
        self.title = "Chat Name"
        
        frameMessageView.backgroundColor = UIColor.darkGrayColor()
        
        mLbl.text = "Type your message here..."
        mLbl.backgroundColor = UIColor.clearColor()
        mLbl.textColor = UIColor.darkGrayColor()
        messageTxtView.addSubview(mLbl)
        
        messageTxtView.layer.cornerRadius = 5
        messageTxtView.layer.borderColor = UIColor.lightGrayColor().CGColor
        messageTxtView.layer.borderWidth = 0.5
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWasShown), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
        let tapScrollViewGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScrollView))
        tapScrollViewGesture.numberOfTapsRequired = 1
        resultScrollView.addGestureRecognizer(tapScrollViewGesture)
        
        //sendBtn.layer.borderColor = UIColor.init(red: 84/255.0, green: 209/255.0, blue: 182/255.0, alpha: 1.0).CGColor
        //sendBtn.layer.borderWidth = 0.5
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.refreshResults()
    }
    
    func didTapScrollView() {
        self.view.endEditing(true)
    }
    
    func textViewDidChange(textView: UITextView) {
        if !messageTxtView.hasText() {
            self.mLbl.hidden = false
        } else {
            self.mLbl.hidden = true
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if !messageTxtView.hasText() {
            self.mLbl.hidden = false
        }
    }
    
    func keyboardWasShown(notification: NSNotification) {
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
            self.resultScrollView.frame.origin.y = self.scrollViewOriginalY - rect.height
            self.frameMessageView.frame.origin.y = self.frameMessageOriginalY - rect.height
            
            let bottomOfSet:CGPoint = CGPointMake(0, self.resultScrollView.contentSize.height - self.resultScrollView.bounds.size.height)
            self.resultScrollView.setContentOffset(bottomOfSet, animated: false)
            
            }, completion: {
                (finished: Bool) in
        })
        
    }

    func keyboardWillHide(notification: NSNotification) {
        let dict:NSDictionary = notification.userInfo!
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect:CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
            self.resultScrollView.frame.origin.y = self.scrollViewOriginalY
            self.frameMessageView.frame.origin.y = self.frameMessageOriginalY
            
            let bottomOfSet:CGPoint = CGPointMake(0, self.resultScrollView.contentSize.height - self.resultScrollView.bounds.size.height)
            self.resultScrollView.setContentOffset(bottomOfSet, animated: false)
            
            }, completion: {
                (finished: Bool) in
        })
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        messageTxtView.resignFirstResponder()
        return true
    }
    
    func refreshResults() {
        let theWidth = view.frame.width
        
        messageX = 37.0
        messageY = 26.0
        
        frameX = 32.0
        frameY = 21.0
        
        messagArray.removeAll(keepCapacity: false)
        senderArray.removeAll(keepCapacity:  false)
        
        
        let innerP1 = NSPredicate(format: "Sender = %@ AND Other = %@", userName, otherName)
        //print(userName + otherName)
        let innerQ1:PFQuery = PFQuery(className: "Messages", predicate: innerP1)
        let innerP2 = NSPredicate(format: "Sender = %@ AND Other = %@", otherName, userName)
        let innerQ2:PFQuery = PFQuery(className: "Messages", predicate: innerP2)
        
        let query = PFQuery.orQueryWithSubqueries([innerQ1, innerQ2])
        query.addAscendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects:[PFObject]? , error:NSError? ) -> Void in
            if error == nil {
                for obj in objects! {
                    self.senderArray.append(obj.objectForKey("Sender") as! String)
                    self.messagArray.append(obj.objectForKey("Message") as! String)
                    //print(self.senderArray.count)
                }
                
                for subview in self.resultScrollView.subviews {
                    subview.removeFromSuperview()
                }
                
                //print(self.messageArray.count)
                var i = 0
                while i <= self.messagArray.count-1 {
                    if self.senderArray[i] == userName {
                        let messageLbl:UILabel = UILabel()
                        let padding: CGFloat = 10
                        messageLbl.frame = CGRectMake(padding, padding, self.resultScrollView.frame.size.width-94, CGFloat.max)
                        messageLbl.backgroundColor = UIColor.init(red: 84/255.0, green: 209/255.0, blue: 182/255.0, alpha: 1.0)
                        messageLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLbl.textAlignment = NSTextAlignment.Left
                        messageLbl.numberOfLines = 0
                        messageLbl.font = UIFont(name: "Helvetica Neuse", size: 14)
                        messageLbl.textColor = UIColor.whiteColor()
                        messageLbl.text = self.messagArray[i]
                        messageLbl.sizeToFit()
                        messageLbl.layer.zPosition = 20
                        messageLbl.layer.cornerRadius = 5
                        //messageLbl.layer.borderWidth = 0.5
                        messageLbl.frame.origin.x = (self.resultScrollView.frame.size.width - self.messageX) - messageLbl.frame.size.width
                        messageLbl.frame.origin.y = self.messageY
                        self.resultScrollView.addSubview(messageLbl)
                        self.messageY += messageLbl.frame.size.height + 35
                        
//                        let frameLbl:UILabel = UILabel()
//                        frameLbl.frame.size = CGSizeMake(messageLbl.frame.width + 10, messageLbl.frame.height + 10)
//                        frameLbl.frame.origin.x = (self.resultScrollView.frame.size.width - self.frameX) - frameLbl.frame.size.width
//                        frameLbl.frame.origin.y = self.frameY
//                        frameLbl.backgroundColor = UIColor.groupTableViewBackgroundColor()
//                        frameLbl.layer.masksToBounds = true
//                        frameLbl.layer.cornerRadius = 10
//                        self.frameMessageView.addSubview(frameLbl)
//                        self.frameY += frameLbl.frame.size.height + 20
                        
                        
                        self.resultScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                        
                    }
                    else {
                        let messageLbl:UILabel = UILabel()
                        messageLbl.frame = CGRectMake(0, 0, self.resultScrollView.frame.size.width-94, CGFloat.max)
                        messageLbl.backgroundColor = UIColor.whiteColor()
                        messageLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLbl.textAlignment = NSTextAlignment.Left
                        messageLbl.numberOfLines = 0
                        messageLbl.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLbl.textColor = UIColor.blackColor()
                        messageLbl.text = self.messagArray[i]
                        messageLbl.sizeToFit()
                        messageLbl.layer.zPosition = 20
                        messageLbl.frame.origin.x = self.messageX
                        messageLbl.frame.origin.y = self.messageY
                        self.resultScrollView.addSubview(messageLbl)
                        self.messageY += messageLbl.frame.size.height + 30
                        
//                        let frameLbl:UILabel = UILabel()
//                        frameLbl.frame = CGRectMake(self.frameX, self.frameY, messageLbl.frame.size.width+10, messageLbl.frame.size.height+10)
//                        frameLbl.backgroundColor = UIColor.groupTableViewBackgroundColor()
//                        frameLbl.layer.masksToBounds = true
//                        frameLbl.layer.cornerRadius = 10
//                        self.frameMessageView.addSubview(frameLbl)
//                        self.frameY += frameLbl.frame.size.height + 20
//                        
                        
                        self.resultScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                    }
                    
                    
                    let bottomOfSet:CGPoint = CGPointMake(0, self.resultScrollView.contentSize.height - self.resultScrollView.bounds.size.height)
                    self.resultScrollView.setContentOffset(bottomOfSet, animated: false)
                    i += 1
                }
            }
        }
    }
    
    
    @IBAction func sendBtn(sender: AnyObject) {
        if messageTxtView.text == "" {
            print("no text")
        } else {
            let messageDBTable = PFObject(className: "Messages")
            messageDBTable["Sender"] = userName
            messageDBTable["Other"] = otherName
            messageDBTable["Message"] = self.messageTxtView.text
            messageDBTable.saveInBackgroundWithBlock{
                (success: Bool?, error: NSError?) -> Void in
                if success == true {
                    self.messageTxtView.text = ""
                    self.mLbl.hidden = false
                    self.refreshResults()
                    self.resignFirstResponder()
                }
            }
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
