//
//  ShadowView.swift
//  Upload Form Data
//
//  Created by Leon Baird on 19/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    let shadowColor = UIColor(white: 0, alpha: 0.5).CGColor
    let borderColor = UIColor(white: 0.8, alpha: 1).CGColor
    let fillColor   = UIColor.whiteColor().CGColor

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // make size smaller to accomodate shadow
        var boxSize = bounds
        boxSize.size.width -= 10
        boxSize.size.height -= 10
        
        // Drawing code
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(ctx, borderColor)
        CGContextSetLineWidth(ctx, 3)
        CGContextSetFillColorWithColor(ctx, fillColor)
        
        CGContextSaveGState(ctx)
        
        CGContextSetShadowWithColor(ctx, CGSize(width: 2, height: 2), 8, shadowColor)
        CGContextFillRect(ctx, boxSize)
        
        CGContextRestoreGState(ctx)
        
        boxSize.size.height -= 3
        boxSize.size.width  -= 3
        boxSize.origin.x = 2
        boxSize.origin.y = 2
        CGContextStrokeRect(ctx, boxSize)
    }
    

}
