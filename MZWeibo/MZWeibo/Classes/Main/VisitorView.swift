//
//  VisitorView.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/5.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit

protocol VisitorViewDelegate: NSObjectProtocol{
    func loginBtnWillClick()
    func registerBtnWillClick()
    
}

class VisitorView: UIView {
    
    //定义一个属性保存代理对象
    //一定加上weak，防止循环引用
    weak var delegate: VisitorViewDelegate?
    /**
     通过判断改变未登录每个页面的信息
     
     - parameter isHome:    是否为首页
     - parameter imageName: 图标
     - parameter message:   文本
     */
    func setUpVisitorViewInfo(isHome: Bool,imageName: String,message: String){
        //如果不是首页，就隐藏转盘
        iconView.hidden = !isHome
        //修改图标
        homeIcon.image = UIImage(named: imageName)
        //修改文本
        messageLabel.text = message
        //判断是否为首页，执行动画
        if isHome
        {
            startAnmation()
        }
        
    }
    func loginBtnClick(){
      //  print(__FUNCTION__)
        delegate?.loginBtnWillClick()
    }
    func registerBtnClick(){
      //  print(__FUNCTION__)
        delegate?.registerBtnWillClick()
    }
   override init(frame: CGRect) {
        super.init(frame: frame)
    //1、添加子控件
    addSubview(iconView)
    addSubview(maskBGView)
    addSubview(homeIcon)
    addSubview(messageLabel)
    addSubview(loginButton)
    addSubview(registerButton)
    //2、布局子控件
    //2.1、设置背景
    iconView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
    //2.2、设置图标
    homeIcon.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
    //2.3、设置文本
    messageLabel.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: iconView, size: nil)
    /// "哪个控件"的"什么属性" "等于" "另外一个控件" 的 "什么属性" 乘以 "多少" 加上 "多少"
    let widthCons = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224)
    addConstraint(widthCons)
    //2.4、设置按钮
    registerButton.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
    loginButton.xmg_AlignVertical(type: XMG_AlignType.BottomRight, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
    //2.5、设置遮挡
    maskBGView.xmg_Fill(self)
    }
    
    //Swift 推荐我们自定义一个控件，要么用纯代码，要么用xib/storyboard
    required init?(coder aDecoder: NSCoder) {
        //如果通过xib/storyboard创建该类，那么就会崩溃
      fatalError("init(coder:) has not been implemented")
    }
    //MARK -- 内部控制方法 --
    private func startAnmation(){
        //1、创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        //2、设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 20;
        anim.repeatCount = MAXFLOAT
        //该属性默认为yes，代表动画执行完毕就移除
        anim.removedOnCompletion = false
        //3、将动画添加到图层
        iconView.layer.addAnimation(anim, forKey: nil)
    }
    //懒加载控件
    /// 转盘
    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
    }()
    /// 图标
    private lazy var homeIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return iv
    }()
    /// 文本
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "嘿嘿，学习是正办，丰富知识是正办，哪那么多借口"
        label.numberOfLines = 0
        return label
    }()
    /// 登陆按钮
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("登陆", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: "loginBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.addTarget(self, action: "registerBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    private lazy var maskBGView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return iv
    }()

}
