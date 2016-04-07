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
        //注册通知，监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: PopoverAnimationWillshow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: PopoverAnimationWilldismiss, object: nil)
        
    }
    deinit{
        //移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    /**
     修改标题按钮的状态
     */
    func change(){
        //修改标题按钮的状态
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.selected = !titleBtn.selected
    }
    func titleBtnClick(btn: TitleButton){
        //1、修改箭头的方向
//        btn.selected = !btn.selected
        //2、弹出菜单
        let pop_sb = UIStoryboard(name: "PopcoverViewController", bundle: nil)
        let vc = pop_sb.instantiateInitialViewController()
        //2.1设置转场代理
        //默认情况下model会移除以前控制器的view，替换为当前控制器的view
        //如果自定义转场，就不会移除以前的控制器的view
//        vc?.transitioningDelegate = self
        vc?.transitioningDelegate = popverAnimatior
        //2.2设置转场样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(vc!, animated: true, completion: nil)
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
        //设置标题
        let titleBtn = TitleButton()
        titleBtn.setTitle("N小姐的M先生  ", forState: UIControlState.Normal)
        titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleBtn
        
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
    //MARK: - 懒加载 
    //一定要定义一个属性来保存自定义转场对象，否则会报错
    private lazy var popverAnimatior: PopoverAnimation = {
       let pa = PopoverAnimation()
        pa.pressentFrame = CGRect(x: 100, y: 56, width: 200, height: 350)
        return pa
    }()
}
// MARK: - UIViewControllerTransitioningDelegate