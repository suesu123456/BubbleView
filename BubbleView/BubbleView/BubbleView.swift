//
//  BubbleView.swift
//  Ujiacity
//
//  Created by apple on 2016/11/7.
//  Copyright © 2016年 ujiacity. All rights reserved.
//

import UIKit

let X_PROP = screenWidth / 320;
let Y_PROP = screenHeight / 480;

let SIZE_PROP = screenWidth / 320;

let LARGE_BUBBLE_SIZE: CGFloat = 100.0;
let LARGE_BUBBLE_SIZE2: CGFloat = 90.0;
let LARGE_BUBBLE_SIZE3: CGFloat = 80.0;
let MIDDLE_BUBBLE_SIZE: CGFloat = 70.0;
let SMALL_BUBBLE_SIZE: CGFloat = 50.0;


struct Bubble4 {
    var frames: [CGRect] = [CGRect(x: 110*X_PROP, y: 80*Y_PROP, width: LARGE_BUBBLE_SIZE*SIZE_PROP, height: LARGE_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 220*X_PROP, y: 155*Y_PROP, width: LARGE_BUBBLE_SIZE2*SIZE_PROP, height: LARGE_BUBBLE_SIZE2*SIZE_PROP),
                            CGRect(x: 35*X_PROP, y: 165*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 120*X_PROP, y: 200*Y_PROP, width: LARGE_BUBBLE_SIZE3*SIZE_PROP, height: LARGE_BUBBLE_SIZE3*SIZE_PROP) ];
    var colors: [UIColor] = [UIColor(hexString: "#3DE2EC"), UIColor(hexString: "#E397E8"), UIColor(hexString: "#EDE563"), UIColor(hexString: "#55fab6")];
    var titles: [String] = ["轻体验", "直播", "定制", "抽奖"];
    
}
struct Bubble9 {
    var frames: [CGRect] = [CGRect(x: 110*X_PROP, y: 60*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 200*X_PROP, y: 80*Y_PROP, width: SMALL_BUBBLE_SIZE*SIZE_PROP, height: SMALL_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 20*X_PROP, y: 120*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 60*X_PROP, y: 180*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 160*X_PROP, y: 200*Y_PROP, width: SMALL_BUBBLE_SIZE*SIZE_PROP, height: SMALL_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 227*X_PROP, y: 130*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP),
                            CGRect(x: 130*X_PROP, y: 125*Y_PROP, width: MIDDLE_BUBBLE_SIZE*SIZE_PROP, height: MIDDLE_BUBBLE_SIZE*SIZE_PROP) ];
    var colors: [UIColor] = [UIColor.magenta, UIColor.red, UIColor.blue, UIColor.gray, UIColor.cyan, UIColor.yellow, UIColor.orange, UIColor.brown, UIColor.purple];
    var titles: [String] = ["婚纱摄影", "蜜月", "酒店", "抽奖", "红包", "直播", "主持人"];
    
}


class BubbleView: UIView {
    
    var views: [UIView] = [];
    var views2: [UIView] = [];
    
    
    var status: Int = 0;
    var bubbleCount: Int = 0;
    var selectViewPoint: CGPoint?
    var selectViewColor: UIColor?
    
    var animationTimer: Timer?;
    var bubbleIndex: Int = 0;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        //初始化两个Views
        let v1 = Bubble4();
        for bubble in 0..<v1.frames.count {
            let bubbleView = UIView(frame: v1.frames[bubble]);
            bubbleView.layer.cornerRadius = bubbleView.frame.size.width / 2;
            bubbleView.clipsToBounds = true;
            bubbleView.backgroundColor = UIColor.clear;
            self.addSubview(bubbleView);
            
            let titleLabel = UILabel(frame: CGRect(x: 5, y: bubbleView.frame.size.height/2-20, width: bubbleView.frame.size.width-10, height: 40));
            titleLabel.textAlignment = .center;
            titleLabel.text = v1.titles[bubble];
            titleLabel.textColor = v1.colors[bubble];
            bubbleView.addSubview(titleLabel);
            bubbleView.isHidden = true;
            bubbleView.tag = bubble;
            self.addTapGestureToView(view: bubbleView, target: self, selector: #selector(onTapBubbleView));
            views.append(bubbleView);
        }
        let v2 = Bubble9();
        for bubble in 0..<v2.frames.count {
            let bubbleView = UIView(frame: v2.frames[bubble]);
            bubbleView.layer.cornerRadius = bubbleView.frame.size.width / 2;
            bubbleView.clipsToBounds = true;
            bubbleView.backgroundColor = UIColor.clear;
            self.addSubview(bubbleView);
            
            let titleLabel = UILabel(frame: CGRect(x: 5, y: bubbleView.frame.size.height/2-20, width: bubbleView.frame.size.width-10, height: 40));
            titleLabel.textAlignment = .center;
            titleLabel.text = v2.titles[bubble];
            titleLabel.textColor = UIColor.white;
            bubbleView.addSubview(titleLabel);
            bubbleView.isHidden = true;
            bubbleView.tag = bubble;
            self.addTapGestureToView(view: bubbleView, target: self, selector: #selector(onTapBubbleView2));
            views2.append(bubbleView);
        }
        showViews()
    }
    func showViews() {
         bubbleIndex = 0;
         self.perform(#selector(animateBubble), with: nil, afterDelay: TimeInterval(0.1));
    }
    
    func animateBubble() {
        animationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateBubbleAction), userInfo: nil, repeats: true);
    }
    func animateBubbleAction() {
        var vw: UIView;
        var color: UIColor?;
        if status == 0 {
            vw = views[bubbleIndex];
            bubbleCount = views.count;
            color = Bubble4().colors[bubbleIndex];
        }else{
            vw = views2[bubbleIndex];
            bubbleCount = views2.count;
            color = Bubble9().colors[bubbleIndex];
        }
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options:     UIViewAnimationOptions.allowUserInteraction, animations:{
            vw.isHidden = false;
        }, completion: {(finished: Bool) in
            vw.startPulseWith(color: UIColor.white, offset: CGSize(width: 4, height: 3), frequency: 2, borderColor: color!);
        });
        if bubbleIndex == bubbleCount - 1 {
            animationTimer?.invalidate();
        }
        bubbleIndex += 1;
    }
    
    func addTapGestureToView(view: UIView, target: Any, selector: Selector) {
        view.isUserInteractionEnabled = true;
        let tap = UITapGestureRecognizer(target: target, action: selector);
        tap.numberOfTapsRequired = 1;
        view.addGestureRecognizer(tap);
    }
    func onTapBubbleView(rec: UITapGestureRecognizer) {
        let selectView = rec.view;
        if status == 0 {
            self.status = 1;
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 9, options: .curveEaseInOut, animations: {
                self.selectViewPoint = selectView?.center;
                self.selectViewColor = selectView?.backgroundColor;
                selectView?.center = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height - 80);
                selectView?.backgroundColor = UIColor.black;
                for vm in self.views {
                    if vm.tag != selectView?.tag {
                       vm.isHidden = true;
                    }
                }
                self.showViews();
            }, completion: {(finished: Bool) in
                selectView?.isUserInteractionEnabled = true;
            })
        }else{
            self.status = 0;
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 9, options: .curveEaseInOut, animations: {
                selectView?.center = self.selectViewPoint!;
                selectView?.backgroundColor = self.selectViewColor;
                for vm in self.views2 {
                    vm.isHidden = true;
                }
                 self.showViews();
            }, completion: {(finished: Bool) in
               
            })
        }
    }
    func onTapBubbleView2(rec: UITapGestureRecognizer) {
        let v = rec.view!
        //泡沫动画
        let ani2 = CABasicAnimation(keyPath: "opacity")
        ani2.fromValue = 0.5
        ani2.toValue = 0
        ani2.isRemovedOnCompletion = false
        ani2.fillMode = kCAFillModeForwards
        ani2.duration = 1
        v.layer.add(ani2, forKey: nil)
        //放射动画
        let emitter = CAEmitterLayer()
        emitter.frame = v.bounds
        v.layer.addSublayer(emitter)
        //configure emitter
        emitter.emitterShape = kCAEmitterLayerCircle //发射源的形状
        emitter.emitterMode = kCAEmitterLayerOutline //发射模式
        emitter.renderMode = kCAEmitterLayerOldestFirst //渲染模式
        emitter.emitterSize = CGSize(width: 25, height: 0)
        emitter.emitterPosition = CGPoint(x: emitter.frame.size.width/2.0, y: emitter.frame.size.height/2.0); //发射源中心
        //create a particle template
        let cell = CAEmitterCell()
        cell.name = "explosion"
        cell.contents = UIImage(named: "water")?.cgImage
        cell.birthRate = 0 //每秒钟产生的粒子数量，默认是0.
        cell.lifetime = 0.7 //每一个粒子的生存周期多少秒
        cell.lifetimeRange = 0.3
        cell.color = UIColor.white.cgColor //每个粒子的颜色
        cell.alphaRange = 0.2
        cell.alphaSpeed = -1 //粒子透明度在生命周期内的改变速度
        cell.velocity = 40 //粒子速度
        cell.velocityRange = 10 //每个粒子的速度变化范围
        cell.emissionRange = CGFloat(M_PI_2) //周围发射角度变化范围
        cell.alphaRange = 0.2//一个粒子的颜色alpha能改变的范围
        cell.scale = 0.1
        cell.scaleRange = 0.05
        emitter.emitterCells = [cell]
        
        emitter.beginTime = CACurrentMediaTime();
        let ani = CABasicAnimation(keyPath:"emitterCells.explosion.birthRate")
        ani.fromValue = 0;
        ani.toValue = 400;
        emitter.add(ani, forKey: nil)
       

    }
    
    

}
