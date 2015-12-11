//
//  ViewController.swift
//  Manual Views
//
//  Created by Trainer on 13/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var imageView:UIImageView!
    weak var label:UILabel!
    weak var button:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = UIImageView(image: UIImage(named: "robot.png"))
        imageView.contentMode = .ScaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        view.addConstraints([
            NSLayoutConstraint(
                item: imageView,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: imageView,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterY,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: imageView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: view,
                attribute: .Width,
                multiplier: 0.4,
                constant: 0
            ),
            NSLayoutConstraint(
                item: imageView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Width,
                multiplier: 1,
                constant: 0
            )
        ])
        
        // make label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hi there from in the code"
        label.textColor = UIColor.purpleColor()
        label.font = UIFont.systemFontOfSize(18)
        view.addSubview(label)
        
        view.addConstraints([
            NSLayoutConstraint(
                item: label,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: -2.0
            ),
            NSLayoutConstraint(
                item: label,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterX,
                multiplier: 1.0,
                constant: 0
            )
        ])
        
        // Make Button
        let button = UIButton(type: .System)
        button.setTitle("I will do something amazing", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        view.addConstraints([
            NSLayoutConstraint(
                item: button,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: view,
                attribute: .RightMargin,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: button,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: view,
                attribute: .BottomMargin,
                multiplier: 1.0,
                constant: -10
            ),
            NSLayoutConstraint(
                item: button,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: 30.0
            )
        ])
        
        // store in properties
        self.imageView = imageView
        self.label = label
        self.button = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

