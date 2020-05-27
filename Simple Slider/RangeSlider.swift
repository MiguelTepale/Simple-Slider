//
//  RangeSlider.swift
//  Simple Slider
//
//  Created by Miguel Tepale on 5/16/20.
//  Copyright © 2020 Miguel Tepale. All rights reserved.
//

import UIKit

class RangeSlider: UIControl {
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    var minimumValue: CGFloat = 0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var maximumValue: CGFloat = 1 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var lowerValue: CGFloat = 0.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var upperValue: CGFloat = 0.5 {
        didSet {
            updateLayerFrames()
        }
    }
    
    // work in progress
    var data = [(label:String, color:CGColor)]() {
        didSet {
            newTrackLayer.data = data
        }
    }
    
    var sliderControlLength: CGFloat {
        return 20.00
    }
    
    var trackTintColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackHighlightTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    private let newTrackLayer = SliderBar()
    private let sliderControl = SliderControl()
    private let trackLayer = RangeSliderTrackLayer()
    private var previousLocation = CGPoint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        trackLayer.rangeSlider = self
//        trackLayer.contentsScale = UIScreen.main.scale
//        layer.addSublayer(trackLayer)
        
        // work in progress
        newTrackLayer.slider = self
        newTrackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(newTrackLayer)
        
        sliderControl.slider = self
        sliderControl.contentsScale = UIScreen.main.scale
        layer.addSublayer(sliderControl)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
//        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
//        trackLayer.setNeedsDisplay()
        
        // work in progress
        newTrackLayer.frame = bounds
        newTrackLayer.setNeedsDisplay()
        
        sliderControl.frame = CGRect(origin: thumbOriginForValue(upperValue), size: CGSize(width: sliderControlLength, height: sliderControlLength))
        sliderControl.setNeedsDisplay()

        CATransaction.commit()
    }
    func positionForValue(_ value: CGFloat) -> CGFloat {
        // returns location of image on track layer using "upperValue"
        return bounds.width * value
    }
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        // imageView x midpoint will line up with track layer x midpoint
        let x = positionForValue(value) - sliderControlLength / 2.0
        // imageView y midpoint will line up with track layer y midpoint
        return CGPoint(x: x, y: (bounds.height - sliderControlLength) / 2.0)
    }
}

// Touch events
extension RangeSlider {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    
        previousLocation = touch.location(in: self)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // Determine how much the user has dragged
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width

        previousLocation = location

        // Update values
        upperValue += deltaValue
        upperValue = boundValue(upperValue, toLowerValue: minimumValue, upperValue: maximumValue)

        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // Update after the tracking has ended
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat, upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
    
}
