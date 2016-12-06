//
//  InnerShadow.swift
//  BubbleView
//
//  Created by sue on 2016/11/28.
//  Copyright © 2016年 ujiacity. All rights reserved.
//

import UIKit

class InnerShadow: CAShapeLayer {
    // 常用属性
    var innerShadowColor: CGColor = UIColor.black.cgColor {
        didSet {
            self.needsDisplay()
        }
    }
    var innerShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var innerShadowRadius: CGFloat = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var innerShadowOpacity: Float = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init() {
        super.init()
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initialize()
    }
    
    func initialize() {
        self.masksToBounds = true
        self.shouldRasterize = true //使用bitmap缓存
        self.contentsScale = UIScreen.main.scale
        self.rasterizationScale = UIScreen.main.scale
        
        setNeedsDisplay()
    }
    
    override func draw(in ctx: CGContext) {
        // 允许抗锯齿
        ctx.setAllowsAntialiasing(true);
        // 允许平滑
        ctx.setShouldAntialias(true);
        // 设置插值质量
        ctx.interpolationQuality = .high;
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        var rect   = self.bounds
        var radius = self.cornerRadius
        //去处边框大小
        if self.borderWidth != 0 {
            rect = rect.insetBy(dx: self.borderWidth, dy: self.borderWidth)
            radius -= self.borderWidth
            radius = max(radius, 0)
        }
         // 创建 inner shadow 的镂空路径
        let someInnerPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
        ctx.addPath(someInnerPath)
        ctx.clip()
        // 创建阴影填充区域，并镂空中心
        let shadowPath = CGMutablePath()
        let shadowRect = rect.insetBy(dx: -rect.size.width, dy: -rect.size.width)
        shadowPath.addRect(shadowRect)
        shadowPath.addPath(someInnerPath)
        shadowPath.closeSubpath()
        // 获取填充颜色信息
        let oldComponents: [CGFloat] = innerShadowColor.components!
        var newComponents: [CGFloat] = [0, 0, 0, 0]
        let numberOfComponents: Int = innerShadowColor.numberOfComponents
        switch (numberOfComponents){
        case 2:
            // 灰度
            newComponents[0] = oldComponents[0]
            newComponents[1] = oldComponents[0]
            newComponents[2] = oldComponents[0]
            newComponents[3] = oldComponents[1] * CGFloat(innerShadowOpacity)
        case 4:
            // RGBA
            newComponents[0] = oldComponents[0]
            newComponents[1] = oldComponents[1]
            newComponents[2] = oldComponents[2]
            newComponents[3] = oldComponents[3] * CGFloat(innerShadowOpacity)
        default: break
        }
        
        // 根据颜色信息创建填充色
        let innerShadowColorWithMultipliedAlpha = CGColor(colorSpace: colorspace, components: newComponents)
        
        // 填充阴影
        ctx.setFillColor(innerShadowColorWithMultipliedAlpha!)
        ctx.setShadow(offset: innerShadowOffset, blur: innerShadowRadius, color: innerShadowColorWithMultipliedAlpha)
        ctx.addPath(shadowPath)
        ctx.fillPath()
        
        
    }

}
