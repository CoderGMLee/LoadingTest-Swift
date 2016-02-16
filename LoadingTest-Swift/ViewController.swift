//
//  ViewController.swift
//  LoadingTest-Swift
//
//  Created by 李国民 on 16/2/1.
//  Copyright © 2016年 李国民. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    var btn : UIButton?
    var loadingView : DMLoadingView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        btn = UIButton(type: UIButtonType.Custom)
        btn?.frame = CGRectMake(0, 100, 100, 100)
        btn?.center = CGPointMake(100, 100)
        btn?.setTitle("开始", forState: UIControlState.Normal)
        btn?.backgroundColor = UIColor.grayColor()
        btn?.addTarget(self, action: "btnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn!)
    }

    func btnClicked(){
        if loadingView == nil {
            let frame = CGRectMake(200, 300, 50, 50)
            loadingView = DMLoadingView(frame: frame)
            loadingView?.center = CGPointMake(self.view.center.x, self.view.center.y)
            self.view.addSubview(loadingView!)
            loadingView?.startAnimation()
        }
    }
}

