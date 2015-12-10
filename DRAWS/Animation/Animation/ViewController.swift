//
//  ViewController.swift
//  Animation
//
//  Created by Trainer on 13/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var robot: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var matrix = robot.transform
        matrix = CGAffineTransformScale(matrix, 0.5, 0.5)
        matrix = CGAffineTransformRotate(matrix, CGFloat(M_PI))
        matrix = CGAffineTransformTranslate(matrix, 0.0, 500.0)
        robot.transform = matrix
        robot.alpha = 0.0
        
        UIView.animateWithDuration(3.0,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1,
            options: .CurveEaseOut,
            animations: {
                self.robot.transform = CGAffineTransformIdentity
                self.robot.alpha = 1.0
            },
            completion: nil
        )
        
        setupSidePanel()
    }
    
    var sidePanel:UIViewController!
    var sideMatrix = CGAffineTransformMakeTranslation(-120.0, 0.0)
    
    func setupSidePanel() {
        sidePanel = storyboard!.instantiateViewControllerWithIdentifier("SideBar")
        view.addSubview(sidePanel.view)
        sidePanel.view.frame.size.width = 120.0
        sidePanel.view.transform = sideMatrix
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fadeIn(sender: AnyObject) {
        UIView.animateWithDuration(2.0) {
            self.robot.alpha = 1.0
            self.robot.transform = CGAffineTransformIdentity
        }
    }

    @IBAction func fadeOut(sender: AnyObject) {
        UIView.animateWithDuration(2.0) {
            self.robot.alpha = 0.0
            self.robot.transform = CGAffineTransformMakeScale(2.0, 2.0)
        }
    }
    
    // MARK: - Gesture Recognisers
    
    @IBAction func showSidePanel(sender: AnyObject) {
        UIView.animateWithDuration(0.5) {
            self.sidePanel.view.transform = CGAffineTransformIdentity
        }
    }
    
    @IBAction func hideSidePanel(sender: AnyObject) {
        UIView.animateWithDuration(0.5) {
            self.sidePanel.view.transform = self.sideMatrix
        }
    }
    
}

