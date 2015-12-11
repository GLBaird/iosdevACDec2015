//
//  ViewController.swift
//  Making Views
//
//  Created by Leon Baird on 16/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let redView = UIView()
        redView.backgroundColor = UIColor.redColor()
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blueColor()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blueView)
        
        let viewRef = [
            "redView": redView,
            "blueView": blueView
        ]
        
        view.addConstraint(
            NSLayoutConstraint(
                item: redView,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: view,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1,
                constant: 0
            )
        )
        
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-20-[redView]-20-|",
                options: [],
                metrics: nil,
                views: viewRef
            )
        )
        
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[blueView(100)]-10-[redView(200)]",
                options: NSLayoutFormatOptions.AlignAllCenterX,
                metrics: nil,
                views: viewRef
            )
        )
        
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:[blueView(100)]",
                options: [],
                metrics: nil,
                views: viewRef
            )
        )
    }
    
    func withVerboseConstraints() {
        let redView = UIView()
        redView.backgroundColor = UIColor.redColor()
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blueColor()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blueView)
        
        view.addConstraints([
            NSLayoutConstraint(
                item: redView,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: view,
                attribute: NSLayoutAttribute.LeftMargin,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: redView,
                attribute: NSLayoutAttribute.Right,
                relatedBy: NSLayoutRelation.Equal,
                toItem: view,
                attribute: NSLayoutAttribute.RightMargin,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: redView,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: view,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: redView,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 200
            ),
            NSLayoutConstraint(
                item: blueView,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 100
            ),
            NSLayoutConstraint(
                item: blueView,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 100
            ),
            NSLayoutConstraint(
                item: blueView,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: redView,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: blueView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: redView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1,
                constant: -10
            )
        ])
    }
    
    func withoutConstraints() {
        let redView = UIView(frame: CGRect(x: 10, y: 30, width: view.bounds.width-20, height: 50))
        redView.backgroundColor = UIColor.redColor()
        redView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleWidth]
        view.addSubview(redView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

