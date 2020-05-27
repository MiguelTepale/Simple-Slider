//
//  ViewController.swift
//  Simple Slider
//
//  Created by Miguel Tepale on 5/14/20.
//  Copyright © 2020 Miguel Tepale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let rangeSlider = RangeSlider(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rangeSlider)
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
                              for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        // set rangeSlider properties
        let margin: CGFloat = 20
        let width = view.bounds.width - 2 * margin
        let height: CGFloat = 30
        
        rangeSlider.frame = CGRect(x: 0, y: 0,
                                   width: width, height: height)
        rangeSlider.center = view.center
        
        // work in progress
        initializeSlider(slider: rangeSlider)
    }
    
    // work in progress
    func initializeSlider(slider: RangeSlider) {
        slider.data.removeAll()
        slider.data.append(("N/A", UIColor.black.cgColor))
        slider.data.append(("1", UIColor.red.cgColor))
        slider.data.append(("2", UIColor.red.cgColor))
        slider.data.append(("3", UIColor.red.cgColor))
        slider.data.append(("4", UIColor.red.cgColor))
        slider.data.append(("5", UIColor.yellow.cgColor))
        slider.data.append(("6", UIColor.yellow.cgColor))
        slider.data.append(("7", UIColor.yellow.cgColor))
        slider.data.append(("8", UIColor.green.cgColor))
        slider.data.append(("9", UIColor.green.cgColor))
        slider.data.append(("10", UIColor.green.cgColor))
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
        print("Range slider value changed: \(values)")
    }

}

