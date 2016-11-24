//
//  BubbleView.swift
//  Ujiacity
//
//  Created by apple on 2016/11/7.
//  Copyright © 2016年 ujiacity. All rights reserved.
//

import UIKit

let screenWidth    = UIScreen.main.bounds.size.width
let screenHeight   = UIScreen.main.bounds.size.height




class BubbleView: UIView {
    
    var views: [UIView] = [];
    var bubbleFrames: [CGRect] = [];  /** 气泡Frame，即产生个数 */
    var bubbleColors: [UIColor] = []  /** 气泡颜色 */
    var bubbleTitles: [String] = []   /** 气泡标题 */
    
    var animationTimer: Timer?;
    var bubbleIndex: Int = 0;         /** 用于记录出现气泡的下标 */
    
    /**
     *  初始化Views
     *  @param
     *  @return
     */
    func initViews(_ frames: [CGRect], _ colors: [UIColor], _ titles: [String]) {
        guard frames.count > 0 else {
            return
        }
        bubbleFrames = frames
        bubbleColors = colors
        bubbleTitles = titles
        for bubble in 0..<bubbleFrames.count {
            let bubbleView = UIView(frame: bubbleFrames[bubble])
            bubbleView.layer.cornerRadius = bubbleView.frame.size.width / 2
            bubbleView.clipsToBounds = true
            bubbleView.backgroundColor = UIColor.clear
            self.addSubview(bubbleView)
            if titles.count == frames.count {
                let titleLabel = UILabel(frame: CGRect(x: 5, y: bubbleView.frame.size.height/2-20, width: bubbleView.frame.size.width-10, height: 40))
                titleLabel.textAlignment = .center
                titleLabel.text = bubbleTitles[bubble]
                if colors.count == frames.count {
                    titleLabel.textColor = bubbleColors[bubble]
                }
                bubbleView.addSubview(titleLabel)
            }
            bubbleView.isHidden = true
            bubbleView.tag = bubble
            self.addEmitterLayer(bubbleView)
            self.addTapGestureToView(view: bubbleView, target: self, selector: #selector(onTapBubbleView))
            views.append(bubbleView)
        }
        showViews()
    }
    func addEmitterLayer(_ v: UIView) {
        let emitter = CAEmitterLayer()
        emitter.frame = v.bounds
        v.layer.addSublayer(emitter)
        //configure emitter
        emitter.emitterShape = kCAEmitterLayerCircle //发射源的形状
        emitter.emitterMode = kCAEmitterLayerOutline //发射模式
        emitter.renderMode = kCAEmitterLayerOldestFirst //渲染模式
        emitter.emitterSize = CGSize(width: 50, height: 0)
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
    }
    /**
     *  逐渐出现动画
     *  @param
     *  @return
     */
    func showViews() {
         self.perform(#selector(animateBubble), with: nil, afterDelay: TimeInterval(0.1))
    }
    
    func animateBubble() {
        animationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateBubbleAction), userInfo: nil, repeats: true)
    }
    func animateBubbleAction() {
        guard bubbleIndex < bubbleFrames.count else {
            return
        }
        let vw: UIView =  views[bubbleIndex]
        let color: UIColor = bubbleColors.count == bubbleFrames.count ? bubbleColors[bubbleIndex] : UIColor.white
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options:     UIViewAnimationOptions.allowUserInteraction, animations:{
            vw.isHidden = false
        }, completion: {(finished: Bool) in
            vw.startPulseWith(color: UIColor.white, offset: CGSize(width: 4, height: 3), frequency: 2, borderColor: color)
            self.bubbleIndex += 1
        });
    }
    func addTapGestureToView(view: UIView, target: Any, selector: Selector) {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: selector)
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    /**
     *  点击消失事件
     *  @param
     *  @return
     */
    func onTapBubbleView(rec: UITapGestureRecognizer) {
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
        var emitter: CAEmitterLayer!
        if v.layer.sublayers?.count == 2 {
            emitter = v.layer.sublayers![1] as! CAEmitterLayer
        }else{
             emitter = v.layer.sublayers![0] as! CAEmitterLayer
        }
        emitter.beginTime = CACurrentMediaTime();
        let ani = CABasicAnimation(keyPath:"emitterCells.explosion.birthRate")
        ani.fromValue = 0;
        ani.toValue = 400;
        emitter.add(ani, forKey: nil)
    }
    

}
