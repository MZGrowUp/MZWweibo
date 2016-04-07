//
//  PopoverAnimation.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/6.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

//定义常量保存通知的名称
let PopoverAnimationWillshow = "PopoverAnimationWillshow"
let PopoverAnimationWilldismiss = "PopoverAnimationWilldismiss"

class PopoverAnimation: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning
{
    /// 记录当前是否展开
    var ispresent: Bool = false
    /// 定义属性保存菜单的大小
    var pressentFrame = CGRectZero
    //实现代理方法，谁来负责转场动画
    //UIPresentationController 是iOS8专门负责转场动画的
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        let pc = PopverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        pc.pressentFrame = pressentFrame
        return pc
        
    }
    //MARK: - 只要实现了以下方法，那么系统自带的默认动画就没有了，所以东西都需要程序猿自己来实现
    /**
    告诉系统谁来负责model的展现动画
    
    - parameter presented:  被展现的视图
    - parameter presenting: 发起的视图
    - parameter source:
    
    - returns: 谁来负责
    */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        //发送通知，通知控制器即将展开
        NSNotificationCenter.defaultCenter().postNotificationName(PopoverAnimationWillshow, object: self)
        ispresent = true
        return self
    }
    /**
     告诉系统谁来负责model的消失动画
     
     - parameter dismissed: 被关闭的视图
     
     - returns: 谁。。。
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        //发送通知，通知控制器即将关闭
        NSNotificationCenter.defaultCenter().postNotificationName(PopoverAnimationWilldismiss, object: self)
        ispresent = false
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
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        //1、拿到展现的视图
        if ispresent
        {
            print("展开")
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            //注意：一定要将视图添加到容器上
            transitionContext.containerView()?.addSubview(toView)
            //设置锚点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            //2、执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                //清空transform
                toView.transform = CGAffineTransformIdentity
                }) { (_) -> Void in
                    //动画执行完毕，一定要告诉系统
                    //如果不写，可能发生未知的错误
                    transitionContext.completeTransition(true)
            }
        }else
        {
            print("关闭")
            //需要关闭
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                //压扁
                //注意：由于CGFloat是不准确的，所以如果写0.0会没有动画
                fromView.transform = CGAffineTransformMakeScale(1.0, 0.000001)
                }, completion: { (_) -> Void in
                    //动画执行完毕，一定要告诉系统
                    //如果不写，可能发生未知的错误
                    transitionContext.completeTransition(true)
            })
            
        }
        
    }
    
}
