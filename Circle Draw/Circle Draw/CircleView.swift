//
//  CircleView.swift
//  Circle Draw
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    var position:CGPoint!
    var diameter:CGFloat = UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 100.0 : 200.0
    var color:UIColor = UIColor.blueColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var circleRect:CGRect {
        return CGRect(
            x: position.x - diameter / 2.0,
            y: position.y - diameter / 2.0,
            width: diameter,
            height: diameter
        )
    }
    private let shadowColor = UIColor.blackColor().CGColor

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if position == nil {
            position = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        }
        
        let ctx = UIGraphicsGetCurrentContext()
        color.setFill()
        
        // add drop shadow
        CGContextSetShadowWithColor(ctx, CGSize(width: 2.0, height: 2.0), 5.0, shadowColor)
        
        // Fill ellipse
        CGContextFillEllipseInRect(ctx, circleRect)
        
    }
    
    // MARK: - Responder methods
    
    var touchesTracked = Set<UITouch>()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touchesTracked.count == 0 && touches.count <= 2)
            || (touchesTracked.count == 1 && touches.count == 1) {
                touchesTracked.unionInPlace(touches)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchesTracked.count == 1 {
            // move
            position = touches.first!.locationInView(self)
        } else {
            // pinch
            let fingers = Array<UITouch>(touchesTracked)
            let touch1Pos = fingers[0].locationInView(self)
            let touch2Pos = fingers[1].locationInView(self)
            
            let diffX = touch1Pos.x - touch2Pos.x
            let diffY = touch1Pos.y - touch2Pos.y
            
            diameter = sqrt( diffX*diffX + diffY*diffY )
            position.x = touch1Pos.x - diffX/2.0
            position.y = touch1Pos.y - diffY/2.0
        }
        
        // trigger redraw of screen
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchesTracked.subtractInPlace(touches)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if touches != nil {
            touchesEnded(touches!, withEvent: event)
        }
    }

}
