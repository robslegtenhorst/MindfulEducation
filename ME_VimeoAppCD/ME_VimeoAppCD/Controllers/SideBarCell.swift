//
//  SideBarCell.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 25/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa

class SideBarCell: NSTableCellView {
    
    fileprivate struct Constants {
        static let barHeight: CGFloat = 30.0
        static let barMinHeight: CGFloat = 20.0
        static let barMaxHeight: CGFloat = 40.0
        static let marginSize: CGFloat = 0.0
        static let pieChartWidthPercentage: CGFloat = 1.0
        static let pieChartBorderWidth: CGFloat = 1.0
        static let pieChartMinRadius: CGFloat = 30.0
        static let pieChartGradientAngle: CGFloat = 90.0
        static let barChartCornerRadius: CGFloat = 4.0
        static let barChartLegendSquareSize: CGFloat = 8.0
        static let legendTextMargin: CGFloat = 5.0
    }
    
    
    
    @IBOutlet weak var menuBgItem: NSBox!
    
//    @IBOutlet weak var textField_Name: NSTextField!
    
    override var backgroundStyle: NSBackgroundStyle {
        didSet {
            if self.backgroundStyle == .light {
//                self.textField?.textColor = NSColor.controlTextColor
            } else if self.backgroundStyle == .dark {
//                self.textField?.textColor = NSColor.alternateSelectedControlTextColor
            }
        }
    }
    
    func setSelected () {
        let toPoint:CGPoint = CGPoint(x: 400.0, y: 0.0)
        let fromPoint:CGPoint = CGPoint.zero
        let movement = CABasicAnimation(keyPath: "position")
        movement.isAdditive = true
        movement.fromValue = fromPoint
        movement.toValue = toPoint
        movement.duration = 0.3
        menuBgItem.layer?.add(movement, forKey: "move")
    }
    
    func drawBarGraphInContext(context: CGContext?) {
        let barChartRect = barChartRectangle()
        drawRoundedRect(rect: barChartRect, inContext: context,
                        radius: Constants.barChartCornerRadius,
                        borderColor: NSColor.blue.cgColor,
                        fillColor: NSColor.black.cgColor)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        //TODO: add var to control button background
        let context = NSGraphicsContext.current()?.cgContext
        drawBarGraphInContext(context: context)
    }
}


extension SideBarCell {
    func barChartRectangle() -> CGRect {
        let rect = CGRect(x: 0,
                          y: 0,
                          width: 160, height: 30)
        return rect
    }
    
    func drawRoundedRect(rect: CGRect, inContext context: CGContext?,
                         radius: CGFloat, borderColor: CGColor, fillColor: CGColor) {
        // 1
        let path = CGMutablePath()
        
        // 2
        path.move( to: CGPoint(x:  rect.midX, y:rect.minY ))
        path.addArc( tangent1End: CGPoint(x: rect.maxX, y: rect.minY ),
                     tangent2End: CGPoint(x: rect.maxX, y: rect.maxY), radius: 10)
        path.addArc( tangent1End: CGPoint(x: rect.maxX, y: rect.maxY ),
                     tangent2End: CGPoint(x: rect.minX, y: rect.maxY), radius: 10)
        path.addArc( tangent1End: CGPoint(x: rect.minX, y: rect.maxY ),
                     tangent2End: CGPoint(x: rect.minX, y: rect.minY), radius: 0)
        path.addArc( tangent1End: CGPoint(x: rect.minX, y: rect.minY ),
                     tangent2End: CGPoint(x: rect.maxX, y: rect.minY), radius: 0)
        path.closeSubpath()
        
        // 3
        context?.setFillColor(fillColor)
        
        // 4
        context?.addPath(path)
        context?.drawPath(using: .fill)
    }
}
