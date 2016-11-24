//
//  ViewController.swift
//  BubbleView
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 ujiacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        backImage.image = UIImage(named: "pattern")
        self.view.addSubview(backImage)

        let X_PROP = screenWidth / 320;
        let Y_PROP = screenHeight / 480;
        
        let SIZE_PROP = screenWidth / 320;
        
        let MIDDLE_BUBBLE_SIZE: CGFloat = 70.0;
        let SMALL_BUBBLE_SIZE: CGFloat = 50.0;
        
        let frames: [CGRect] = [CGRect(x: 110*X_PROP, y: 60*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                                CGRect(x: 200*X_PROP, y: 80*Y_PROP, width: SMALL_BUBBLE_SIZE*SIZE_PROP, height: SMALL_BUBBLE_SIZE*SIZE_PROP),
                                CGRect(x: 20*X_PROP, y: 120*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                                CGRect(x: 60*X_PROP, y: 180*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                                CGRect(x: 160*X_PROP, y: 200*Y_PROP, width: SMALL_BUBBLE_SIZE*SIZE_PROP, height: SMALL_BUBBLE_SIZE*SIZE_PROP),
                                CGRect(x: 227*X_PROP, y: 130*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                                CGRect(x: 130*X_PROP, y: 125*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP) ];
        let colors: [UIColor] = [UIColor.magenta, UIColor.red, UIColor.blue, UIColor.gray, UIColor.cyan, UIColor.yellow, UIColor.purple];
        let titles: [String] = ["婚纱摄影", "蜜月", "酒店", "抽奖", "红包", "直播", "主持人"];
        
        let bubble = BubbleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        bubble.initViews(frames, colors, titles)
        self.view.addSubview(bubble)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

