//
//  Person.swift
//  Archiving
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {

    var surname:String = "New"
    var forename:String = "New"
    
    var age:Int = 0
    
    init(surname:String, forename:String, age:Int) {
        self.surname = surname
        self.forename = forename
        self.age = age
    }
    
    // MARK: - NSCoding Methods
    
    required init(coder aDecoder: NSCoder) {
        self.surname = aDecoder.decodeObjectForKey("surname") as! String
        self.forename = aDecoder.decodeObjectForKey("forename") as! String
        self.age = aDecoder.decodeIntegerForKey("age")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(surname, forKey: "surname")
        aCoder.encodeObject(forename, forKey: "forename")
        aCoder.encodeInteger(age, forKey: "age")
    }
    
}
