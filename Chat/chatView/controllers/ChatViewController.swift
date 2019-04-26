//
//  ChatViewController.swift
//  Chat
//
//  Created by yetao on 2019/4/25.
//  Copyright © 2019 yetao. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var chatList:UITableView?
    
    var rows = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createTableView()
        
        self.initSomething()
        
    }
    
    func initSomething() {
    
        self.view.backgroundColor = BACKGROUND_Color
//        self.automaticallyAdjustsScrollViewInsets = false
    }

   
    func createTableView(){
        
        chatList = UITableView.init(frame: CGRect(x:0,y:64,width:screenW,height:screenH - 108), style: UITableView.Style.plain)
    
        chatList?.dataSource      = self;
        
        chatList?.backgroundColor = BACKGROUND_Color
        
        chatList?.delegate        = self;
        
        chatList?.showsHorizontalScrollIndicator     = false
        
        chatList?.showsVerticalScrollIndicator       = false;
        
        chatList?.register(ChatListViewCell.self, forCellReuseIdentifier: "listCell")
        
        chatList?.tableFooterView = UIView()
        
        self.view.addSubview((chatList)!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ChatListViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chatVC = ChatDetailViewController()
        
        chatVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsets.zero;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction:UITableViewRowAction = UITableViewRowAction.init(style: UITableViewRowAction.Style.default, title: "删除") { (deleteAction, IndexPath) in
         
            self.rows -= 1
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        return [deleteAction]
    }
    
}





