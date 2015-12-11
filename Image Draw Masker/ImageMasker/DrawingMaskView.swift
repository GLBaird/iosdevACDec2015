//
//  DrawingMaskView.swift
//  ImageMasker
//
//  Created by Leon Baird on 15/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class DrawingMaskView: UIView {
    
    var points = [CGRect]()
    var penColor = UIColor.redColor().CGColor
   
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if imageToMask == nil {
            drawMask()
        } else {
            drawMaskedImage()
        }
    }
    
    func drawMask() {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(ctx, penColor)
        for point in points {
            CGContextFillEllipseInRect(ctx, point)
        }
    }
    
    func drawMaskedImage() {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        
        CGContextSetFillColorWithColor(ctx, penColor)
        for point in points {
            CGContextFillEllipseInRect(ctx, point)
        }
        let mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext())
        UIGraphicsEndImageContext()
        
        let scale = fmin(
            frame.width / imageToMask!.size.width,
            frame.height / imageToMask!.size.height
        )
        let imageSize = CGSize(
            width: imageToMask!.size.width*scale,
            height: imageToMask!.size.height*scale
        )
        let imageRect = CGRect(
            x: bounds.width/2 - imageSize.width/2,
            y: bounds.height/2 - imageSize.height/2,
            width: imageSize.width,
            height: imageSize.height
        )
        
        CGContextTranslateCTM(ctx, 0, bounds.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        
        CGContextClipToMask(ctx, bounds, mask)
        CGContextDrawImage(ctx, imageRect, imageToMask?.CGImage)
            
        CGContextRestoreGState(ctx)
        
        // save to disk
        if let imageToSave = CGBitmapContextCreateImage(ctx) {
            let parsedImage = UIImage(CGImage: imageToSave)
            let imageData = UIImagePNGRepresentation(parsedImage)!
            let today = NSDate().timeIntervalSince1970
            let filename = NSHomeDirectory()+"/documents/\(today).png"
            imageData.writeToFile(filename, atomically: true)
        }
    }
    
    // MARK: - Process methods
    
    func clearMask() {
        points.removeAll()
        setNeedsDisplay()
    }
    
    var imageToMask:UIImage?
    
    func maskImage(image:UIImage) {
        imageToMask = image
        setNeedsDisplay()
    }
    
    
    // MARK: - Responder Methods
    
    var touchBeingTracked:Set<UITouch> = []
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchBeingTracked.count == 0 && touches.count == 1 {
            touchBeingTracked.unionInPlace(touches)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchBeingTracked.isSubsetOf(touches) {
            let point = touchBeingTracked.first!.locationInView(self)
            points.append(
                CGRect(
                    x: point.x - 10,
                    y: point.y - 10,
                    width: 20,
                    height: 20
                )
            )
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchBeingTracked.subtractInPlace(touches)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let t = touches {
            touchesEnded(t, withEvent: event)
        }
    }
    
}
