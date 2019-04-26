//
//  YTChatMessageCell.swift
//  Chat
//
//  Created by yetao on 2019/4/25.
//  Copyright © 2019 yetao. All rights reserved.
//

import UIKit

class YTChatMessageCell: UITableViewCell {
    
    private var iconImageView:UIButton = UIButton()
    
    private var nameLabel:UILabel      = UILabel()
    
    private var messageLabel:UIButton   = UIButton()
    
    private var gifimageView = UIImageView()

    static func cellWithTableView(tableView:UITableView) ->YTChatMessageCell {
    
        let ID:String = "YTChatMessageCell"
        
        let cell:YTChatMessageCell = tableView.dequeueReusableCell(withIdentifier: ID) as! YTChatMessageCell
        
        return cell
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareUI() {

        self.backgroundColor = BACKGROUND_Color
        
        //头像
        iconImageView.layer.cornerRadius  = 5
        iconImageView.layer.masksToBounds = true
        contentView.addSubview(iconImageView)
        
        //消息
        messageLabel.titleLabel?.numberOfLines = 0
        contentView.addSubview(messageLabel)
        
        contentView.addSubview(gifimageView)
        
        //名字
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.orange
        contentView.addSubview(nameLabel)
        
    }
    
    var chatCellFrame:YTChatCellFrame? {
        
        didSet {
            
            let type:Bool = chatCellFrame?.message?.currentUserType == userType.me
            
            //头像
            let iconName:String = chatCellFrame?.message?.currentUserType == userType.me ? "1" : "2"
            iconImageView.setImage(UIImage.init(named: iconName), for: UIControl.State.normal)
            iconImageView.frame = (chatCellFrame?.iconFrame)!
            //名字
            nameLabel.text = chatCellFrame?.message?.userName
            nameLabel.frame = (chatCellFrame?.nameFrame)!
            nameLabel.textAlignment = type ? NSTextAlignment.left : NSTextAlignment.right
            
            if chatCellFrame?.message?.messageType == 0 {
                
                //消息内容
                messageLabel.setAttributedTitle(chatCellFrame?.message?.attMessage, for: UIControl.State.normal)
                messageLabel.frame = (chatCellFrame?.textFrame)!
                let messageImageName:String = type ? "chat_receive_nor" : "chat_send_nor"
                let messageImageNameP:String = type ? "chat_receive_p" : "chat_send_p"
                messageLabel.setBackgroundImage(UIImage.resizebleImage(imageName: messageImageName), for: UIControl.State.normal)
                messageLabel.setBackgroundImage(UIImage.resizebleImage(imageName: messageImageNameP), for: UIControl.State.highlighted)
                messageLabel.titleEdgeInsets = type ? UIEdgeInsets(top: 7, left: 13, bottom: 5, right: 5) : UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 13)
                gifimageView.frame = CGRect()
                
            }
            else if chatCellFrame?.message?.messageType == 1 {
                
                let path:String = Bundle.main.path(forResource: chatCellFrame?.message?.gifName, ofType: "gif")!
                
                let data = NSData.init(contentsOf: NSURL.init(fileURLWithPath: path) as URL)
                
                let animationImage = UIImage.animationImageWithData(data: data);
             
                gifimageView.image =  animationImage;
                
                gifimageView.frame = (chatCellFrame?.imageViewFrame)!
                
                messageLabel.frame = CGRect()
            }
            
        }
    }
}
