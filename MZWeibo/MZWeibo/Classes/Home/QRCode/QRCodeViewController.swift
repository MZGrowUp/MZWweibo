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
        //添加绘制图层到预览图层上
        preViewLayer.addSublayer(drawLayer)
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
    //创建用于绘制变现我的图层
    private lazy var drawLayer: CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
}
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    //只要解析到数据就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        //清空图层
        clearCorners()
        //获取扫描到的数据
        print(metadataObjects.last?.stringValue)
        //注意：使用stringValue
        resultLabel.text = metadataObjects.last?.stringValue
        resultLabel.sizeToFit()
        //获取扫描到二维码的位置
        //print(metadataObjects.last)
        for objc in metadataObjects
        {
            //判断当前获取到的数据，是否是机器可识别到的类型
            if objc is AVMetadataMachineReadableCodeObject
            {
                //转换
                //将坐标转换为可识别的坐标
                let codeObject = preViewLayer.transformedMetadataObjectForMetadataObject(objc as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
//                print(codeObject)
                //绘制图形
                drawCorners(codeObject)

            }
        }
    }
    /**
     绘制图形
     
     - parameter codeObject: 保存了坐标
     */
    private func drawCorners(codeObject: AVMetadataMachineReadableCodeObject)
    {
        if codeObject.corners.isEmpty
        {
            return
        }
        //1、创建一个图层
        let layer = CAShapeLayer()
        layer.lineWidth = 4;
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        //2、创建路径
//        layer.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 100, height: 100)).CGPath
        let path = UIBezierPath()
        var point = CGPointZero
        var index: Int = 0
        //2、1移动到第一个点
//        print(codeObject.corners.last)
        //从corner数组中取出第0个元素，将字典中的x/y赋值给point
        CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++] as! CFDictionaryRef), &point)
        path.moveToPoint(point)
        //移动到其他的店
        while index < codeObject.corners.count
        {
            CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++] as! CFDictionaryRef), &point)
            path.addLineToPoint(point)

        }
        //关闭路径
        path.closePath()
        //绘制路径
        layer.path = path.CGPath
        //3、将绘制号的图层添加到drawLayer上
        drawLayer.addSublayer(layer)
    }
    private func clearCorners(){
        //判断layer上是否有其它子图层
        if drawLayer.sublayers == nil || drawLayer.sublayers?.count == 0{
            return
        }
        
        //清空所以子图层
        for subLayer in drawLayer.sublayers!
        {
            subLayer.removeFromSuperlayer()
        }
    }
}













