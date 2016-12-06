//
//  UIView.swift
//  Ujiacity
//
//  Created by sue on 2016/11/7.
//  Copyright © 2016年 ujiacity. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
   
    //发光动画
    func startPulseWith(color: UIColor, offset: CGSize, frequency: CGFloat, borderColor: UIColor) {
//        self.layer.shadowColor = color.cgColor;
//        self.layer.shadowOffset = offset;
//        self.layer.shadowOpacity = 0.9;
        self.layer.borderColor = borderColor.cgColor;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = true;
//        //animation
//        let anim = CABasicAnimation(keyPath: "shadowOpacity");
//        anim.fromValue = 0.9;
//        anim.toValue = 0.2;
//        anim.duration = CFTimeInterval(frequency);
//        anim.autoreverses = true;
//        anim.repeatCount = Float(Int32.max);
//        self.layer.add(anim, forKey: "Pulse");
    }
    
    func addInnerShadow() {
       
        let shadowLayer = InnerShadow()
        shadowLayer.frame = self.bounds
        shadowLayer.innerShadowOffset = CGSize(width: 4, height: 4)
        shadowLayer.innerShadowOpacity = 0.5
        shadowLayer.innerShadowRadius  = 5
        shadowLayer.innerShadowColor = UIColor.black.cgColor
        self.layer.addSublayer(shadowLayer)

    }

}


