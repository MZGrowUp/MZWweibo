//
//  MainViewController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/5.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //当前控制器对应tabBar的颜色
        tabBar.tintColor = UIColor.orangeColor()
        //1、创建首页
        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        //2、
        addChildViewController(DiscoverTableViewController(), title: "广场", imageName: "tabbar_discover")
        //3、
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        //4、
        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    /**
     初始化子控制器
     
     - parameter childController: 初始化自控制器
     - parameter title:           title
     - parameter imageName:       name
     */
    private func addChildViewController(childController: UIViewController,title: String,imageName:String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        childController.title = title
        let navHome = UINavigationController()
        navHome.addChildViewController(childController)
        //3、将导航控制器添加到当前控制器上
        addChildViewController(navHome)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
