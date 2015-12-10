//
//  ColorMixerViewController.swift
//  Circle Draw
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ColorMixerViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    @IBOutlet weak var colorPreview: UIView!
    
    // outlets for UI tweaks
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var titleBarHeight: NSLayoutConstraint!
    @IBOutlet var viewsToRemove: [UIView]!
    
    
    var mixedColor:UIColor?
    
    var delegate:ColorMixerViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let color = mixedColor {
            
            colorPreview.backgroundColor = color
            
            var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0
            color.getRed(&r, green: &g, blue: &b, alpha: nil)
            
            sliderRed.value   = Float(r)
            sliderGreen.value = Float(g)
            sliderBlue.value  = Float(b)
            
        }
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            titleBar?.rightBarButtonItem = nil
            titleBarHeight?.constant = 44
            for v in viewsToRemove {
                v.removeFromSuperview()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func sliderChanged(sender: UISlider) {
        mixedColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1.0
        )
        
        colorPreview.backgroundColor = mixedColor
        
        delegate?.colorMixerHasMixedNewColor(self, newColor: mixedColor!)
    }

}


protocol ColorMixerViewControllerDelegate {
    
    func colorMixerHasMixedNewColor(mixer:ColorMixerViewController, newColor:UIColor)
    
}





