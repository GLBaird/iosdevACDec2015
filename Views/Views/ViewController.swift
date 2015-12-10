//
//  ViewController.swift
//  Views
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var label:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel()
        label.text = "Welcome to iOS"
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.redColor()
        label.textAlignment = .Center
//        label.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleWidth]
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // pass ownership to view
        view.addSubview(label)
        
        // store in weak reference
        self.label = label
        
        view.addConstraints([
            NSLayoutConstraint(
                item: label,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: label,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: view,
                attribute: .TopMargin,
                multiplier: 1,
                constant: 25
            )
        ])
        
        let button = UIButton(type: .System)
        button.setTitle("Click Me", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // add action to button
        button.addTarget(self, action: "showHelloText:", forControlEvents: .TouchUpInside)
        
        view.addSubview(button)
        
        view.addConstraints([
            NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .BottomMargin, multiplier: 1, constant: -20)
        ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    func showHelloText(sender:UIButton) {
        label.text = "Hello World"
    }


}

