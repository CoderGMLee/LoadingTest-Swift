//
//  DMLoadingView.swift
//  LoadingTest-Swift
//
//  Created by 李国民 on 16/2/1.
//  Copyright © 2016年 李国民. All rights reserved.
//

import UIKit

enum DMLoadingStep : Int{
    case DMLoadingStepOne,DMLoadingStepTwo,DMLoadingStepThree,DMLoadingStepFour,DMLoadingStepFive,DMLoadingStepSix
}
class DMLoadingView: UIView {

    let KRadius : Float = 17
    let KMultipy : Float = 0.8
    let KPointRadius : Float = 4
    let KRotateDuration : Float = 0.5
    let KLineWith : CGFloat = 2.0
    let KFrameInterval = 2

    var context : CGContextRef?
    var rotateAnimaiton : CABasicAnimation?
    var displayLink : CADisplayLink?
    var color : UIColor?

    private var progress : Float = 0
    var step : DMLoadingStep = DMLoadingStep.DMLoadingStepOne
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.config()
    }

    override func drawRect(rect: CGRect) {
        self.context = UIGraphicsGetCurrentContext()
        self.layer.backgroundColor = self.color?.CGColor
        switch self.step{
        case .DMLoadingStepOne:
            self.step1()
        case .DMLoadingStepTwo:
            self.step2()
        case .DMLoadingStepThree:
            self.step3()
        case .DMLoadingStepFour:
            self.step4()
        case .DMLoadingStepFive:
            self.step5()
        case .DMLoadingStepSix:
            self.step6()
        }
        CGContextSetStrokeColorWithColor(self.context, self.color?.CGColor)
        CGContextSetLineWidth(self.context, self.KLineWith)
        CGContextStrokePath(self.context)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(){
        color = UIColor(red: 0.91, green: 0.31, blue: 0, alpha: 1)
        displayLink = CADisplayLink(target: self, selector: "updateLayer")
        displayLink?.frameInterval = KFrameInterval
        displayLink?.paused = true
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }

    func updateLayer(){

        switch step{
        case .DMLoadingStepOne :
            if self.progress < 0.9 {
                self.progress += 0.1
            }else if self.progress >= 0.9 {
                self.step = .DMLoadingStepTwo
                progress = 0
                self.rotateFrom(0, toValue: Float(M_PI) * Float(2))
            }

        case .DMLoadingStepTwo:
            if self.progress < 0.9 {
                self.progress += 0.1
            }

        case .DMLoadingStepThree:
            if self.progress < 1.1 {
                self.progress += 0.1
            }else if self.progress >= 1.1{
                self.step = .DMLoadingStepFour
                progress = 1
            }

        case .DMLoadingStepFour:
            if self.progress > 0.2{
                self.progress -= 0.1
            }else if self.progress < 0.2{
                self.step = .DMLoadingStepFive
                progress = 1
                self.rotateFrom(Float(M_PI) * Float(2), toValue: 0)
            }

        case .DMLoadingStepFive:

            if self.progress > 0.08{
                self.progress -= 0.04
            }

        case .DMLoadingStepSix:

            if self.progress > 0.1{
                self.progress -= 0.1
            }else if self.progress <= 0.1{
                self.step = .DMLoadingStepOne
            }
        }
        self.setNeedsDisplay()
    }

    func step1(){

        let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let path = UIBezierPath()
        path.addArcWithCenter(CGPointMake(center.x, center.y + CGFloat(self.KRadius) * CGFloat(self.progress)), radius: CGFloat(KPointRadius) * CGFloat(self.progress), startAngle: 0, endAngle: CGFloat(M_2_PI), clockwise: true)
        CGContextAddPath(self.context, path.CGPath)

        let path1 = UIBezierPath()
        path1.addArcWithCenter(CGPointMake(center.x, center.y - CGFloat(KRadius * progress)), radius: CGFloat(KPointRadius) * CGFloat(self.progress), startAngle: 0, endAngle: CGFloat(M_2_PI), clockwise: true)
        CGContextAddPath(self.context, path1.CGPath)

        let path2 = UIBezierPath()
        path2.addArcWithCenter(CGPointMake(center.x + CGFloat(KRadius * progress), center.y), radius: CGFloat(KPointRadius) * CGFloat(self.progress), startAngle: 0, endAngle: CGFloat(M_2_PI), clockwise: true)
        CGContextAddPath(self.context, path2.CGPath)

        let path3 = UIBezierPath()
        path3.addArcWithCenter(CGPointMake(center.x - CGFloat(KRadius * progress), center.y), radius: CGFloat(KPointRadius) * CGFloat(self.progress), startAngle: 0, endAngle: CGFloat(M_2_PI), clockwise: true)
        CGContextAddPath(self.context, path3.CGPath)

        CGContextSetAlpha(self.context, CGFloat(progress))

        print("progress1 \(progress)");
    }
    func step2(){

        let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let increment : Float = Float(M_PI_2) * progress * KMultipy

        let path = UIBezierPath()
        path.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: 0, endAngle: CGFloat(increment), clockwise: true)
        CGContextAddPath(self.context, path.CGPath)

        let path1 = UIBezierPath()
        path1.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI_2) + CGFloat(increment), clockwise: true)
        CGContextAddPath(self.context, path1.CGPath)

        let path2 = UIBezierPath()
        path2.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI) + CGFloat(increment), clockwise: true)
        CGContextAddPath(self.context, path2.CGPath)

        let path3 = UIBezierPath()
        path3.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: CGFloat(M_PI) * CGFloat(1.5), endAngle: CGFloat(M_PI) * CGFloat(1.5) + CGFloat(increment), clockwise: true)
        CGContextAddPath(self.context, path3.CGPath)
        print("progress2 \(progress)")
    }
    func step3(){

        let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        let increment : CGFloat = CGFloat(M_PI_2) * CGFloat(progress) * CGFloat(KMultipy)
        let path = UIBezierPath()
        path.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: increment, endAngle: CGFloat(M_PI_2), clockwise: true)
        CGContextAddPath(self.context, path.CGPath)

        let path1 = UIBezierPath()
        path1.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: CGFloat(M_PI_2) + increment, endAngle: CGFloat(M_PI), clockwise: true)
        CGContextAddPath(self.context, path1.CGPath)

        let path2 = UIBezierPath()
        path2.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: CGFloat(M_PI) + increment, endAngle: CGFloat(M_PI) * CGFloat(1.5), clockwise: true)
        CGContextAddPath(self.context, path2.CGPath)

        let path3 = UIBezierPath()
        path3.addArcWithCenter(center, radius: CGFloat(KRadius), startAngle: CGFloat(M_PI) * CGFloat(1.5) + increment, endAngle: CGFloat(M_PI) * CGFloat(2), clockwise: true)
        CGContextAddPath(self.context, path3.CGPath)
        print("progress3 \(progress) increment \(increment)")
    }
    func step4(){
        self.step3()
    }
    func step5(){
        print("progress5")
        self.step2()
    }
    func step6(){
        print("progress6")
        self.step1()
    }

    func rotateFrom(fromValue : AnyObject, toValue : AnyObject){

        rotateAnimaiton = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimaiton?.duration = CFTimeInterval(KRotateDuration)
        rotateAnimaiton?.repeatCount = 1
        rotateAnimaiton?.fromValue = fromValue
        rotateAnimaiton?.toValue = toValue
        rotateAnimaiton?.delegate  = self
        self.layer.addAnimation(rotateAnimaiton!, forKey: "rotate")
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("func : \(__FUNCTION__)")
        if flag == true && self.step == .DMLoadingStepTwo{
            progress = 0
            self.step = .DMLoadingStepThree
        }
        if flag && self.step == .DMLoadingStepFive{
            self.step = .DMLoadingStepSix
            progress = 1
        }
    }

    func startAnimation(){
        self.layer.removeAllAnimations()
        self.step = .DMLoadingStepOne
        self.displayLink?.paused = false
    }
    func stopAnimation(){
        self.layer.removeAllAnimations()
        self.displayLink?.paused = true
        self.step = .DMLoadingStepOne
    }
}




