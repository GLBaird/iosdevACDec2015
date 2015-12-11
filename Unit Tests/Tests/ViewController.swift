//
//  ViewController.swift
//  Tests
//
//  Created by Leon Baird on 18/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getValue(val:Int) -> Int {
        return val * 2
    }
    
    func getName() -> String {
        return "Bob"
    }

}

