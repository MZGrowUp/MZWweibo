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
        //添加所有子控制器
        addChildViewControllers()
        print(tabBar.subviews)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("-------------")
        print(tabBar.subviews)
        //添加加号按钮
        addComposeBtn()
        
    }
    private func addComposeBtn(){
        tabBar.addSubview(composeBtn)
        //调整加号按钮的宽度
        let width = UIScreen.mainScreen().bounds.size.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x: 0, y: 0, width: width, height: 49)
        //第一个参数是frame得大小 
        //第二个参数是x方向偏移的大小
        //第三个参数是y方向偏移的大小
        composeBtn.frame = CGRectOffset(rect, 2*width, 0)
    }
    //加号按钮事件 注意点：监听按钮点击的方法不能是私有方法
     func composeBtnClick(){
        print("加号按钮事件")

    }
    /**
     添加所有子控制器
     */
    private func addChildViewControllers() {
        //1、获取JSON文件的路径
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        //2、通过文件路径创建NSData，进行判断path 一定不为空
        if let jsonPath = path{
            let jsonData = NSData(contentsOfFile: jsonPath)
            do
            {
                //有可能发生异常的代码放到这里
                //3、序列化json数据 --> array
                //try:发生异常会跳到catch中继续执行
                //try!:发生异常程序会直接崩溃
                let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                print(dictArr)
                //4、遍历数组，动态创建控制器和数据
                //在Swift中，如果要遍历数组，必须明确数据的类型
                for dict in dictArr as![[String: String]]
                {
                    //报错的原因：addChildViewController参数必须有值，但字典的返回值为可选类型
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
            }catch
            {
                //发生异常之后执行的代码
                print(error)
                //1、创建首页
                addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
                //2、
                addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
                addChildViewController("NullViewController", title: "", imageName: "")
                //3、
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                //4、
                addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            }
        }
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
   //懒加载
    private lazy var composeBtn: UIButton = {
        let btn = UIButton()
        // 设置前景图片
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        //设置背景图片
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: "composeBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
}
