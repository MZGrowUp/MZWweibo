//
//  AppDelegate.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/1.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        //设置跟视图控制器
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        return true
    }



}

