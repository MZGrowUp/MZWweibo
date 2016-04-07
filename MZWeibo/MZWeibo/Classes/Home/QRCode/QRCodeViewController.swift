//
//  QRCodeViewController.swift
//  MZWeibo
//
//  Created by 李艳楠 on 16/4/7.
//  Copyright © 2016年 Déesse. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController,UITabBarDelegate{
    /// 保存扫描的结果
    @IBOutlet weak var resultLabel: UILabel!
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
        //开始扫描
        startScan()
    }
    /**
     扫描二维码
     */
   private func startScan(){
        //1、判断是否能够将输入添加到对话中
    if !session.canAddInput(deviceInput)
    {
        return
    }
        //2、判断是否能够将输出添加到对话中
    if !session.canAddOutput(output)
    {
        
    }
        //3、将输入和输出都添加到会话中
        session.addInput(deviceInput)
        print(output.metadataObjectTypes)
        session.addOutput(output)
        print(output.metadataObjectTypes)
        //4、设置输出能够解析的数据类型
        //注意：设置能够解析的数据类型，一定要在输出对象添加到会话之后设置，否则会报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        //5、设置输出对象的代理，只要解析成功，就会通知代理
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            //添加预览图层
        view.layer.insertSublayer(preViewLayer, atIndex: 0)
        //6、告诉session开始扫描
        session.startRunning()
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
    //MARK: - 懒加载
    //会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    //拿到输入设备
    private lazy var deviceInput: AVCaptureDeviceInput? = {
        //获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do
        {
           //创建输入对象
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch{
            print(error)
            return nil
        }
    }()
    //拿到输出对象
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    //创建预览图层
    private lazy var preViewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
}
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    //只要解析到数据就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        print(metadataObjects.last?.stringValue)
        //注意：使用stringValue
        resultLabel.text = metadataObjects.last?.stringValue
        resultLabel.sizeToFit()
    }
}













