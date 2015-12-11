//
//  ViewController.swift
//  Archiving
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let people = [
            Person(surname: "Baird", forename: "Leon", age: 40),
            Person(surname: "Jones", forename: "Indiana", age: 100),
            Person(surname: "Evil", forename: "Doctor", age: 20)
        ]
        
        let filepath = NSHomeDirectory() + "/Documents/users.dat"
        
        NSKeyedArchiver.archiveRootObject(people, toFile: filepath)
        
        let loadedPeople = NSKeyedUnarchiver.unarchiveObjectWithFile(filepath) as! [Person]
        
        print("Loaded data \(loadedPeople)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

