/*
 The MIT License (MIT)
 
 Copyright (c) 2015-present Badoo Trading Limited.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import Foundation
import Chatto
import ChattoAdditions
import Parse


//var userName = "sky@gmail.com"
//var otherName = "flower@gmail.com"

var messagArray = [String]()
var senderArray = [String]()

var object = [PFObject]()

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

func createTextMessageModel(uid: String, text: String, isIncoming: Bool) -> TextMessageModel {
    let messageModel = createMessageModel(uid, isIncoming: isIncoming, type: TextMessageModel.chatItemType)
    let textMessageModel = TextMessageModel(messageModel: messageModel, text: text)
    return textMessageModel
}

func createMessageModel(uid: String, isIncoming: Bool, type: String) -> MessageModel {
    let senderId = isIncoming ? "1" : "2"
    //let messageStatus = isIncoming || arc4random_uniform(100) % 3 == 0 ? MessageStatus.Success : .Failed
    let messageStatus = MessageStatus.Success
    let messageModel = MessageModel(uid: uid, senderId: senderId, type: type, isIncoming: isIncoming, date: NSDate(), status: messageStatus)
    return messageModel
}

class FakeMessageFactory {
    
    class func createChatItem(uid: String) -> MessageModelProtocol {
        let isIncoming: Bool = arc4random_uniform(100) % 2 == 0
        return self.createChatItem(uid, isIncoming: isIncoming)
    }
    
    class func createChatItem(uid: String, isIncoming: Bool) -> MessageModelProtocol {
        return self.createTextMessageModel(uid, isIncoming: isIncoming)
    }
    
    class func createTextMessageModel(uid: String, isIncoming: Bool) -> TextMessageModel {
        
        let incomingText: String = isIncoming ? "incoming" : "outgoing"
        let maxText = String(object.enumerate())
        let length: Int = 10 + Int(arc4random_uniform(300))
        let text = "Txt:\(maxText), #:\(uid)"

//        return ChattoApp.createTextMessageModel(uid, text: text, isIncoming: isIncoming)
        return FlashFitPro.createTextMessageModel(uid, text: text, isIncoming: isIncoming)
    }
}

extension TextMessageModel {
    static var chatItemType: ChatItemType {
        return "text"
    }
}



class TutorialMessageFactory {
    static func createMessages() -> [MessageModelProtocol] {
        //parse data
        
        messagArray.removeAll(keepCapacity: false)
        senderArray.removeAll(keepCapacity:  false)
        
        let innerP1 = NSPredicate(format: "Sender = %@ AND Other = %@", userName, otherName)
        
        let innerQ1:PFQuery = PFQuery(className: "Messages", predicate: innerP1)
        let innerP2 = NSPredicate(format: "Sender = %@ AND Other = %@", otherName, userName)
        let innerQ2:PFQuery = PFQuery(className: "Messages", predicate: innerP2)
        
        let query = PFQuery.orQueryWithSubqueries([innerQ1, innerQ2])
        query.addAscendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects:[PFObject]? , error:NSError? ) -> Void in
            if error == nil {
                for obj in objects! {
                    senderArray.append(obj.objectForKey("Sender") as! String)
                    messagArray.append(obj.objectForKey("Message") as! String)
                    
                    object = objects!
                }
            }
        }
        
        var result = [MessageModelProtocol]()

        for (index, message) in object.enumerate() {
            let type = "text"
            let content = String(message.objectForKey("Message")!)
            let isIncoming: Bool = String(message.objectForKey("Sender")!) == userName
            
            if type == "text" {
                if (isIncoming){
                    result.append(createTextMessageModel("tutorial-\(index)", text: content, isIncoming: isIncoming))
                } else {
                    result.append(createTextMessageModel("tutorial-\(index)", text: content, isIncoming: isIncoming))
                }
            }
        }
        return result
    }
}
