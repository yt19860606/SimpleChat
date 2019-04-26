//
//  ChatDetailViewController.swift
//  Chat
//
//  Created by yetao on 2019/4/25.
//  Copyright © 2019 yetao. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController  ,UITextViewDelegate ,UITableViewDelegate,UITableViewDataSource,  UINavigationControllerDelegate{
    
    var dataSource:NSMutableArray = NSMutableArray()
    var tableView:UITableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        self.navigationController?.delegate = self
        ScrollTableViewToBottom()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createExampleData()
        initSomething()
        initChatTableView()
        Timer.scheduledTimer(timeInterval: 0.5,target:self,selector:#selector(sendMessage),
                                                       userInfo:nil,repeats:true)
    }
    
    func createExampleData() {
        
        for i: Int in 0..<2 {
        
            let chatCellFrame:YTChatCellFrame = YTChatCellFrame()
            
            let message:YTChatMessage = YTChatMessage()
            
            var messageText = String()
            
            if i == 0 {
                
                message.currentUserType = userType.other
                message.userName = "鸣人"
                message.messageType = 0
                messageText = "在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗[委屈]。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)[害羞]，结果她一脸淡定的回绝了:“二叔！别闹……”[尴尬]"
            }else if i == 1 {
                
                message.currentUserType = userType.me
                message.userName = "路飞"
                message.messageType = 0;
                messageText = "小学六年级书法课后不知是哪个用红纸写了张六畜兴旺贴教室门上，上课语文老师看看门走了，过了一会才来，过了几天去办公室交作业听见语文老师说：看见那几个字我本来是不想进去的，但是后来一想养猪的也得进去喂猪"
            }
            message.message = messageText
            
            chatCellFrame.message = message
            
            dataSource.add(chatCellFrame)
        }
    }

    // 初始化一些数据
    func initSomething() {
        
        self.view.backgroundColor = BACKGROUND_Color
        
        if #available(iOS 11.0, *) {
            
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.title = "路飞"
    }
    
    //创建tabbleView
    func initChatTableView() {
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: screenW, height: screenH - 49 - 64))
        tableView.backgroundColor = BACKGROUND_Color
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(YTChatMessageCell.self, forCellReuseIdentifier: "YTChatMessageCell")
        self.view.addSubview(tableView)

    }

 
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = YTChatMessageCell.cellWithTableView(tableView: tableView)
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let chatCellFrame:YTChatCellFrame = dataSource.object(at: indexPath.row) as! YTChatCellFrame
        
        cell.chatCellFrame = chatCellFrame
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(ChatDetailViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let chatCellFrame:YTChatCellFrame = dataSource.object(at: indexPath.row) as! YTChatCellFrame
        
        return chatCellFrame.cellHeight;
    }
    
    //重设tabbleview的frame并根据是否在底部来执行滚动到底部的动画（不在底部就不执行，在底部才执行）
    func resetChatList() {
    
        let offSetY:CGFloat = tableView.contentSize.height - tableView.height;
        //判断是否滚动到底部，会有一个误差值
        if tableView.contentOffset.y > offSetY - 5 || tableView.contentOffset.y > offSetY + 5 {
            ScrollTableViewToBottom()
        }
    }
    
    //滚动到底部
    func ScrollTableViewToBottom() {
        
        let indexPath:NSIndexPath = NSIndexPath.init(row: self.dataSource.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
    }
    @objc func sendMessage() {

        var messageText = String()
        messageText = "[憨笑]彩笔，怎么可以输入空格呢?[得意]"
        if messageText.count == 0 {
            return
        }
        createDataSource(text: messageText)
        refreshChatList()
    }

    //创建一条数据
    func createDataSource(text:String) {
        
        let i  = arc4random() % 2
        var messageText = String()
        let message:YTChatMessage = YTChatMessage()

        if i == 0 {
            
            message.currentUserType = userType.other
            message.userName = "鸣人"
            message.messageType = 0
            messageText = "在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗[委屈]。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)[害羞]，结果她一脸淡定的回绝了:“二叔！别闹……”[尴尬]"
        }else if i == 1 {
            
            message.currentUserType = userType.me
            message.userName = "路飞"
            message.messageType = 0;
            messageText = "小学六年级书法课后不知是哪个用红纸写了张六畜兴旺贴教室门上，上课语文老师看看门走了，过了一会才来，过了几天去办公室交作业听见语文老师说：看见那几个字我本来是不想进去的，但是后来一想养猪的也得进去喂猪"
        }
        message.message = messageText
        let cellFrame = YTChatCellFrame()
        cellFrame.message = message
        dataSource.add(cellFrame)

    }

    //刷新UI
    func refreshChatList() {
        let indexPath:NSIndexPath = NSIndexPath.init(row: dataSource.count - 1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.none)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
    
}






