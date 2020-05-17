//
//  SliderControl.swift
//  Simple Slider
//
//  Created by Miguel Tepale on 5/16/20.
//  Copyright © 2020 Miguel Tepale. All rights reserved.
//

import UIKit

class SliderControl: CALayer {
    
    weak var slider: RangeSlider?

    override func draw(in ctx: CGContext) {
        let path = UIBezierPath(ovalIn: bounds)
        let color = UIColor(red: CGFloat(70)/255, green: CGFloat(100)/255, blue: CGFloat(150)/255, alpha: 1.0).cgColor
        
        // Fill - with a subtle shadow
        ctx.setFillColor(color)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
    }

    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

}
