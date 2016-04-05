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
            return
        }
        //初始化导航条
        setUpNavgation()
    }
    func leftBtnClick(){
        print(__FUNCTION__)
    }
    func rightBtnClick(){
        print(__FUNCTION__)
    }
    private func setUpNavgation(){
    //"navigationbar_friendattention"
        /*
        navigationItem.leftBarButtonItem = creatBarButton("navigationbar_friendattention", target: self, action: "leftBtnClick")
        navigationItem.rightBarButtonItem = creatBarButton("navigationbar_pop", target: self, action: "rightBtnClick")
        */
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButton("navigationbar_friendattention", target: self, action: "leftBtnClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButton("navigationbar_pop", target: self, action: "rightBtnClick")
        
    }
    /*
    private func creatBarButton(imageName: String, target: AnyObject?, action: Selector)->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
*/
}
