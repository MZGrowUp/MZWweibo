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
        addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
        //2、
        addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
        //3、
        addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
        //4、
        addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
    }
    /**
     初始化子控制器
     
     - parameter childController: 初始化自控制器
     - parameter title:           title
     - parameter imageName:       name
     */
    private func addChildViewController(childControllerName: String,title: String,imageName:String) {
        //<MZWeibo.HomeTableViewController: 0x7fa16244e680>
        //<MZWeibo.HomeTableViewController: 0x7f943bc6d5c0>
       // print(childControllerName)
        //动态的获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        //将字符串转换为类
        //默认情况下命名空间就是项目的名称，但命名空间名称是可以修改的
        let className:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        //将anyClass转换为制定的类型
        let classNameVC = className as! UIViewController.Type
        //通过一个类创建一个对象  注意！！！：不能为空
        let classVC = classNameVC.init()
        print(classVC)
        //通过一个类创建一个控制器
        classVC.tabBarItem.image = UIImage(named: imageName)
        classVC.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        classVC.title = title
        let navHome = UINavigationController()
        navHome.addChildViewController(classVC)
        //3、将导航控制器添加到当前控制器上
        addChildViewController(navHome)

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
