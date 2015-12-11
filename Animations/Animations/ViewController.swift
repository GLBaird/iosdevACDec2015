//
//  ViewController.swift
//  Animations
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var robot: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup robot animation
        var transform = CGAffineTransformScale(robot.transform, 2.0, 2.0)
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
        transform = CGAffineTransformTranslate(transform, 0.0, -300.0)
        
        robot.transform = transform
        robot.alpha = 0
        
        UIView.animateWithDuration(
            4.0,
            delay: 0.0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 2.0,
            options: [.CurveEaseOut, .BeginFromCurrentState],
            animations: { () -> Void in
                self.robot.transform = CGAffineTransformIdentity
                self.robot.alpha = 1.0
            },
            completion: nil
        )
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods

    @IBAction func fadeIn(sender: AnyObject) {
        UIView.animateWithDuration(2.0) { () -> Void in
            self.robot.alpha = 1.0
            self.robot.transform = CGAffineTransformIdentity
        }
    }
    
    @IBAction func fadeOut(sender: AnyObject) {
        UIView.animateWithDuration(2.0) { () -> Void in
            self.robot.alpha = 0.0
            self.robot.transform = CGAffineTransformMakeScale(2.0, 2.0)
        }
    }

}

