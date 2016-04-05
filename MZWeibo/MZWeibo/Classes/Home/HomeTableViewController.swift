//
//  HomeTableViewController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/5.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //如果没有登陆，就设置未登录界面
        if !userLogin
        {
            visitorView?.setUpVisitorViewInfo(true, imageName: "", message: "")
        }
    }
}
