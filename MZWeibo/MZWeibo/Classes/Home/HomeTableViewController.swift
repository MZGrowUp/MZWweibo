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
    func titleBtnClick(btn: TitleButton){
        //1、修改箭头的方向
        btn.selected = !btn.selected
        //2、弹出菜单
        let pop_sb = UIStoryboard(name: "PopcoverViewController", bundle: nil)
        let vc = pop_sb.instantiateInitialViewController()
        //2.1设置转场代理
        //默认情况下model会移除以前控制器的view，替换为当前控制器的view
        //如果自定义转场，就不会移除以前的控制器的view
        vc?.transitioningDelegate = self
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
}
// MARK: - UIViewControllerTransitioningDelegate
extension HomeTableViewController: UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning
{
    //实现代理方法，谁来负责转场动画
    //UIPresentationController 是iOS8专门负责转场动画的
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        
        return PopverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        
    }
    /**
     告诉系统谁来负责model的展现动画
     
     - parameter presented:  被展现的视图
     - parameter presenting: 发起的视图
     - parameter source:
     
     - returns: 谁来负责
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }
    /**
     告诉系统谁来负责model的消失动画
     
     - parameter dismissed: 被关闭的视图
     
     - returns: 谁。。。
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }
    //MARK: - UIViewControllerAnimatedTransitioning
    /**
    返回动画时长
    
    - parameter transitionContext: 上下文，里面保存了动画的所有参数
    
    - returns: 动画时长
    */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 20
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        
    }
}
