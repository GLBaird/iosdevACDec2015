//: Playground - noun: a place where people can play

import UIKit


class Person {
    
    private var _surname:String = "BOB"
    
    var surname:String {
        get {
            return _surname
        }
        set {
            _surname = newValue
        }
    }
    
    
    lazy var forename:String = {
        return "BOB"
    } ()
    
    var fullName:String {
        return forename + " " + surname
    }
    
    var count = 0 {
        willSet {
            
        }
        didSet {
            
        }
    }
    
    init(surname:String, forename:String) {
        self.surname = surname
        self.forename = forename
    }
    
    convenience init(surname:String, forename:String, counter:Int) {
        self.init(surname: surname, forename: forename)
        self.count = counter
    }
    
    func getFullName() -> String {
        return forename+" "+surname
    }
    
}


var person1 = Person(surname: "Baird", forename: "Leon")
person1.getFullName()
person1.forename = "Bob"

person1.getFullName()



// switch and case

let myValue = 3

switch myValue {
    
    case 0:
        print("The value is 0")
    fallthrough
        
    case 1:
        print("The value is 1")
        
    case 3, 4, 10, 15:
        print("Lots of values")
        
    case 50...100:
        print("Between 50 and 100")
        
    default:
        print("Unknow value")
    
}


