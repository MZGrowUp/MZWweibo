//
//  QRCodeViewController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/7.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController,UITabBarDelegate{

    /// 容器视图高度越苏
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    /// 冲击波视图顶部上的约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    /// 冲击波 imageView
    @IBOutlet weak var scanLineView: UIImageView!
    
    @IBAction func closeBtnClick(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBOutlet weak var customerTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //设置底部视图默认选中第一个
        customerTabBar.selectedItem = customerTabBar.items![0]
        customerTabBar.delegate = self
    }
    
    
    
    //执行冲击波动画
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    //开始动画
    private func startAnimation(){
        //让约束从顶部开始
        self.scanLineCons.constant = -self.containerHeightCons.constant
        //强制更新界面
        self.scanLineView.layoutIfNeeded()
        UIView.animateWithDuration(5.0, animations: { () -> Void in
            //1、修改约束
            self.scanLineCons.constant = self.containerHeightCons.constant
            //设置动画指定的次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            //2、强制更新界面
            self.scanLineView.layoutIfNeeded()
        })

    }
    
   //MARK: - UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //1、修改容器的高度
        if item.tag == 1
        {
            print("二维码")
            self.containerHeightCons.constant = 300
        }else{
            print("条形码")
            self.containerHeightCons.constant = 150
        }
        //2、停止动画
        self.scanLineView.layer.removeAllAnimations()
        //3、开始动画
        startAnimation()
    }
    

}
