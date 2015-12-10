//
//  ViewController.swift
//  Hello World
//
//  Created by Leon Baird on 07/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // actions

    @IBAction func clickMe(sender: AnyObject) {
        label.text = "Hello World"
    }
    
    @IBAction func reset(sender: AnyObject) {
        label.text = "Label"
    }
    

}

