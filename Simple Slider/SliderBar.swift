//
//  SliderBar.swift
//  Simple Slider
//
//  Created by Miguel Tepale on 5/20/20.
//  Copyright © 2020 Miguel Tepale. All rights reserved.
//

import UIKit

class SliderBar: CALayer {
    
    // MARK: - Properties
    weak var slider: RangeSlider?
    
    var centerLine: CGFloat = 16.804
    var data = [(label:String, color:CGColor)]()
    var delimiter_height = CGFloat(0)
    let font = UIFont(name: "Avenir Next", size: 12)!
    let greenColor = UIColor(red: 0, green: CGFloat(132)/255, blue: 0, alpha: 1.0).cgColor
    var margin:CGFloat = 20.0
    var textAttributes = [String: AnyObject]()
    var textHeight = CGFloat(0)
    
    // MARK: - Lifecycle
    override func draw(in ctx: CGContext) {
        
        updateProperties()
        
        // Create noncolored horizontal line
        let cornerRadius = CGFloat(1.0)
        let theRect = CGRect(x: bounds.origin.x + margin, y: bounds.origin.y + 0.0, width: bounds.width - 2 * margin, height: 5.0)
        let path = UIBezierPath(roundedRect: theRect, cornerRadius: cornerRadius)
        ctx.addPath(path.cgPath)
        
        // Fill the highlighted range
        
        if data.count == 0 || data.count == 1
        {
            return
        }
        
        let segment = (theRect.width) / CGFloat(data.count - 1)
        
        let centerLineHeight = CGFloat(2.0)

        
        // Color each segment
        for i in 0..<data.count - 1 {
            // Color new segments white
            ctx.setFillColor(UIColor.white.cgColor)
            var rect = CGRect(x: CGFloat(i) * segment + margin, y: centerLine - centerLineHeight / 2, width: segment, height: centerLineHeight + 1)
            ctx.fill(rect)
            
            // Color new segments with specified color
            ctx.setFillColor(data[i].color)
            rect = CGRect(x: CGFloat(i) * segment + margin, y: centerLine - centerLineHeight / 2, width: segment, height: centerLineHeight)
            ctx.fill(rect)
        }
        
        // Draw a vertical line
        for i in 0..<data.count {
            let delimiter_width: CGFloat = 1.0
            
            ctx.setFillColor(greenColor)
            let x = CGFloat(i) * segment + margin - delimiter_width / 2
            
            let rect2 = CGRect(x: x, y: 0, width: delimiter_width, height: delimiter_height)
            ctx.fill(rect2)
        }
        
        // iPhone の座標系と Core Graphics の座標系は、左下が原点なためそのまま描画をすると反転してしまう
        // CGContextSetTextMatrix で反転させ CGContextTranslateCTM で並行移動
        ctx.translateBy(x: 0, y: self.bounds.size.height);//これは必要
        ctx.scaleBy(x: 1.0, y: -1.0);// 反転させる。（これをしないと文字が逆立ちします）
        ctx.textMatrix = CGAffineTransform.identity
        
        
        for i in 0..<data.count {
            
            let text = data[i].label
            let textSize = text.size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary(textAttributes))
            let y = bounds.height - textSize.height - delimiter_height
            
            _ = SliderUtilities.drawText(context: ctx, text: text as NSString, attributes: textAttributes, x: CGFloat(i) * segment + margin, y: y)
        }
        
    }

    // MARK: - Actions
    func updateProperties() {
        
        // Add custom color and font to 'textAttributes'
        textAttributes[convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor)] = greenColor
        textAttributes[convertFromNSAttributedStringKey(NSAttributedString.Key.font)] = font
        
        textHeight = "0".size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary(textAttributes)).height
        delimiter_height = bounds.height - textHeight
        
        centerLine = delimiter_height / 2
        
    }

}

class SliderUtilities {
    static func drawText(context: CGContext, text: NSString, attributes: [String: AnyObject], x: CGFloat, y: CGFloat) -> CGSize {
        let font = attributes[convertFromNSAttributedStringKey(NSAttributedString.Key.font)] as! UIFont
        let attributedString = NSAttributedString(string: text as String, attributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))

        let textSize = text.size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))

        // y: Add font.descender (its a negative value) to align the text at the baseline
        let textPath    = CGPath(rect: CGRect(x: x - textSize.width / 2, y: y + font.descender, width: ceil(textSize.width), height: ceil(textSize.height)), transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
        let frame       = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: attributedString.length), textPath, nil)


        CTFrameDraw(frame, context)

        return textSize
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

