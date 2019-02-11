//
//  MoonSceneVC.swift
//  CCSwift
//
//  Created by job on 2019/1/21.
//  Copyright © 2019 我是花轮. All rights reserved.
//  3D模型惯性旋转 

import UIKit
import SceneKit

class MoonSceneVC: UIViewController {

    //Const
    let MOONREDIS: CGFloat = 50.0                   //月球半径
    let DECELERATION_RATE: CGFloat = 0.85           //惯性时速度衰减比例
    let SPEED: CGFloat = 0.02                       //惯性时每帧的速度
    
    //模型节点
    var moonNode: SCNNode = SCNNode.init()
    
    //用于记录月球当前状态距上一次静止状态的偏移量  也是众多状态set的唯一参数
    var moonXOffect: CGFloat = 0.0
    var moonYOffect: CGFloat = 0.0
    
    //记录moon的偏移速度
    var velocityPoint = CGPoint.init(x: 0, y: 0)
    
    // 当前亮度 范围[0,1]
    var bri: CGFloat = 0.0
    
    // 在月球上方有一组记录bri的的单位标志 根据bri的值 来设置小圆球所在的位置
    lazy var briArray: [CAShapeLayer] = {
       var briArray = [CAShapeLayer]()
        
        for i in 0...10{
            var shapeLayer = CAShapeLayer.init()
            var path = UIBezierPath.init()
            let bri: CGFloat = 0.1 * CGFloat(i)
            path.move(to: getPoint(bri: bri))
            path.addLine(to: getPoint(bri: bri))
            
            shapeLayer.fillColor = UIColor.white.cgColor
            shapeLayer.strokeColor = UIColor.white.cgColor
            shapeLayer.lineJoin = CAShapeLayerLineJoin.round
            shapeLayer.lineCap = CAShapeLayerLineCap.round
            shapeLayer.lineWidth = 5
            shapeLayer.path = path.cgPath;

            briArray.append(shapeLayer)
        }
        return briArray
    }()
    
    lazy var briLayer: UIView = {
        var briLayer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 12, height: 12))
        briLayer.backgroundColor = UIColor.white
        briLayer.layer.masksToBounds = true
        briLayer.layer.cornerRadius = 6
        briLayer.layer.shadowColor = UIColor.white.cgColor
        briLayer.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        briLayer.layer.shadowOpacity = 0.5
        
        return briLayer
    }()
    
    lazy var displayLink: CADisplayLink = {
        var displayLink = CADisplayLink.init(target: self, selector: #selector(decelerationStep))
        return displayLink
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1、创建视图
        //2、创建场景
        //3、创建月球模型、节点
        //4、添加观察者
        //5、添加手势
        
        let scnView = SCNView.init(frame:view.bounds)
        scnView.backgroundColor = UIColor.black
        view.addSubview(scnView)
        scnView.allowsCameraControl = false    //控制手势 默认false
        scnView.showsStatistics = true       //调试数据 默认false
        
        let scene = SCNScene()
        scnView.scene = scene
        
        let moon = SCNSphere.init(radius: MOONREDIS)
        moon.segmentCount = 100 //渲染网格数 越多越逼真 消耗越大
        moon.firstMaterial?.diffuse.contents = UIImage.init(named: "bg_func_moon")
        moonNode.geometry = moon
        moonNode.position = SCNVector3Make(0, 0, 0);
        scene.rootNode.addChildNode(moonNode)
        
        let cameraNode = SCNNode.init()
        cameraNode.camera = SCNCamera.init()
        cameraNode.camera?.automaticallyAdjustsZRange = true
        cameraNode.position = SCNVector3Make(0, 0, Float(MOONREDIS * 5));
        scene.rootNode.addChildNode(cameraNode)

        let panGes = UIPanGestureRecognizer.init(target: self, action:  #selector(panAction(panges:)))
        scnView.addGestureRecognizer(panGes)
        
        // 将bri背景放置
        for layer in briArray {
            self.view.layer.addSublayer(layer)
        }
        
        
        
    }
    
    // 根据bri[0,1]来计算的briLayer的中心点
    func getPoint(bri: CGFloat) -> CGPoint {
        
        // 当前的位置的弧度
        let radian = Double.pi * ((60 + Double(60 * bri)) / 180)
        // Y 轴距圆点距离 两种方式
        let shiftH = CGFloat(sin(radian)) * 150
        // X 轴距圆点距离
        let shiftW = cosf(Float(radian)) * 150

        let x = kScreenWitdh * 0.5 - CGFloat(shiftW)
        let y = kScreenHeight * 0.5 - CGFloat(shiftH)
        
        return CGPoint.init(x: x, y: y)
    }

    @objc func panAction(panges:UIPanGestureRecognizer) -> () {
        //1、获取当前手势的相对位置
        if panges.state == .began {
            // 关键功能 在一次滑动之后调用 可以刷新当前的node的位置 将最终位置设置为初始位置
            self.updateNodePivot(node: moonNode)
        }
        
        let panX = panges.translation(in: self.view).x
        let panY = panges.translation(in: self.view).y
        //2、将手势位置复制给moon当做偏移量
        moonXOffect = panX
        moonYOffect = panY
        
        self.changeMoonState()

        if panges.state == .ended {
            velocityPoint = panges.velocity(in: self.view)
            self.beginDecelerate()
        }

    }

    //根据moonXOffect、moonYOffect 修改月球状态
    func changeMoonState() -> () {
        let angle: CGFloat = sqrt(pow(moonXOffect, 2) + pow(moonYOffect, 2)) * CGFloat((.pi/180.0))
        moonNode.rotation = SCNVector4Make(Float(moonYOffect), Float(moonXOffect), 0, Float(angle * 0.8));
    }

    //🌹关键功能 在一次滑动之后调用 可以刷新当前的node的位置 将最终位置设置为初始位置
    func updateNodePivot(node: SCNNode) -> () {
        let matrix = node.pivot
        let changeMatrix = SCNMatrix4Invert(node.transform)
        node.pivot = SCNMatrix4Mult(changeMatrix, matrix);
        node.transform = SCNMatrix4Identity;
    }

    //开始惯性滑动
    func beginDecelerate() -> () {
        //开启计时器
        displayLink.preferredFramesPerSecond = 0
        displayLink.add(to: RunLoop.main, forMode: .common)
    }
    
    //停止惯性滑动
    func endDecelerate() -> () {
        //开启计时器
        displayLink.isPaused = true
        displayLink.invalidate()
        
    }
    
    // 根据当前速度减速
    @objc func decelerationStep() -> () {
        //1、获取当前速度
        let newVelocity = CGPoint.init(x: self.velocityPoint.x * DECELERATION_RATE, y: self.velocityPoint.y * DECELERATION_RATE)
        //2、设置位置距离
        let moveX = newVelocity.x * SPEED
        let moveY = newVelocity.y * SPEED
        //3、修改moon偏移量 并刷新
        moonXOffect += moveX
        moonYOffect += moveY
        self.changeMoonState()
        if abs(moveX) <= 0.0000000001 && abs(moveY) <= 0.0000000001 {
            self.endDecelerate()
        }else{
            velocityPoint = newVelocity
        }
    }
}
