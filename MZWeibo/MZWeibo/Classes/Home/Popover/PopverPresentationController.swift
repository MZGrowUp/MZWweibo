//
//  PopverPresentationController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/6.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class PopverPresentationController: UIPresentationController {

    /**
     初始化方法，用于创建负责转场动画的对象
     
     - parameter presentedViewController:  被展现的控制器
     - parameter presentingViewController: 发起的控制器 xcode6 是nil，xcode7是野指针
     
     - returns: 负责转场动画的对象
     */
    
   override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    
   // print(presentedViewController)
   // print(presentingViewController)
    }
    /**
     即将转场子视图时调用
     */
    override func containerViewWillLayoutSubviews()
    {
    //1、修改弹出视图的大小
    //containerView 容器视图
    //presentedView 被展现的视图
        presentedView()?.frame = CGRect(x: 100, y: 56, width: 200, height: 200)
     //2、在容器视图上添加蒙版，插入到展现的下面
        //因为展现视图和蒙版都在一个视图上，而 后添加的会盖住先添加的
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    // MARK:懒加载 遮盖view
    private lazy var coverView: UIView = {
      let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.mainScreen().bounds
        //添加监听
        let tapGR = UITapGestureRecognizer(target: self, action: "close")
        view.addGestureRecognizer(tapGR)
        return view
    }()
    func close(){
       presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
