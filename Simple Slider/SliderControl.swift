//
//  Slidercontrols.swift
//  Simple Slider
//
//  Created by Miguel Tepale on 5/20/20.
//  Copyright © 2020 Miguel Tepale. All rights reserved.
//

import UIKit
import QuartzCore

///This creates the dark blue circle that traverses along the slider.
class SliderControl: CALayer {
    
    weak var slider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        let circle = UIBezierPath(ovalIn: bounds)
        let darkBlue = UIColor(red: CGFloat(70)/255, green: CGFloat(100)/255, blue: CGFloat(150)/255, alpha: 1.0).cgColor
        
        ctx.setFillColor(darkBlue)
        ctx.addPath(circle.cgPath)
        ctx.fillPath()
    }
    
}

