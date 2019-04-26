//
//  YTChatMessage.swift
//  Chat
//
//  Created by yetao on 2019/4/25.
//  Copyright © 2019 yetao. All rights reserved.
//

import UIKit

enum userType {
    
    case me
    
    case other
}


class YTChatMessage: NSObject {
    
    var userName:String = String()
    
    var message:String  = String()
    
    var gifName:String  = String()

    var attMessage      = NSMutableAttributedString()
    
    var currentUserType = userType.me
    
    var messageType:Int = 0
    
}
