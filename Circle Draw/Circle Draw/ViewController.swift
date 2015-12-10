//
//  ViewController.swift
//  Circle Draw
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ColorMixerViewControllerDelegate {
    
    // outlets
    @IBOutlet weak var circleView:CircleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segue Navigation Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "colorMixer" {
            let colorMixer = segue.destinationViewController as! ColorMixerViewController
            colorMixer.mixedColor = circleView.color
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                colorMixer.delegate = self
            }
        }
    }
    
    @IBAction func closeColorMixer(segue:UIStoryboardSegue) {
        let colorMixer = segue.sourceViewController as! ColorMixerViewController
        circleView.color = colorMixer.mixedColor!
    }
    
    // MARK: - ColorMixer Delegate Methods
    
    func colorMixerHasMixedNewColor(mixer: ColorMixerViewController, newColor: UIColor) {
        circleView.color = newColor
    }


}

