//
//  ViewController.swift
//  Langauge
//
//  Created by Leon Baird on 18/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let info = NSLocalizedString("Wow, what a thing!!", comment: "Get this done now!")
        print(info)
        
        label.text = NSLocalizedString("Hi there from me!", comment: "Main greeting")
        
        label.text = NSLocalizedString("Hi there from me!", comment: "Evil greeting")
        
        label.text! += " "+NSLocalizedString("What is happening?", comment: "Question about stuff")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

