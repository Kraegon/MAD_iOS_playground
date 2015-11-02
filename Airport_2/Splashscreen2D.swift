//
//  Splashscreen2D.swift
//  Airport_2
//
//  Created by Julian West on 21/10/15.
//  Copyright © 2015 Jules. All rights reserved.
//

import UIKit

class Splashscreen2D: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let locations: [CGFloat] = [0.0, 0.5, 1.0]
        
        let colors = [UIColor.redColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.cyanColor().CGColor]
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradientCreateWithColors(colorspace,
            colors, locations)
        
        var startPoint =  CGPoint()
        var endPoint  = CGPoint()
        
        startPoint.x = 100
        startPoint.y = 100
        endPoint.x = 200
        endPoint.y = 200
        let startRadius: CGFloat = 10
        let endRadius: CGFloat = 75
        
        CGContextDrawRadialGradient(context, gradient, startPoint,
            startRadius, endPoint, endRadius, CGGradientDrawingOptions.DrawsBeforeStartLocation)
    }

}
