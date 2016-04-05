//
//  BaseTableViewController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/5.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController, VisitorViewDelegate {

    //定义一个变量保存用户当前是否登录
    var userLogin = true
    //定义属性保存未登陆界面
    var visitorView: VisitorView?
    override func loadView() {
        userLogin ?super.loadView(): setUpVisitorView()
    }
    //MARK -- 内部控制方法
    /**
    创建未登录界面
    */
    private func setUpVisitorView(){
        let baseView = VisitorView()
        //baseView.backgroundColor = UIColor.redColor()
        baseView.delegate = self
        view = baseView
        visitorView = baseView
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "registerBtnWillClick")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: "loginBtnWillClick")
    }
    //MARK -- VisitorViewDelegate --
    func loginBtnWillClick() {
        print(__FUNCTION__)
    }
    func registerBtnWillClick() {
        print(__FUNCTION__)
    }
}
