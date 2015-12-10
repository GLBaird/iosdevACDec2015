import Foundation

var username:String = "Leon Baird"
var myAge:UInt = 40
var myFloat:Float = 20.993

var logonName  = "Brian Jones"
var logonAge   = 30
var logonFloat = 304.387463


logonAge = 20

username = "Smith"

username

var constantName = "BOB"

constantName = "Jones"


username.lowercaseString

//var bbcURL = NSURL(string: "http://www.bbc.co.uk")!
//do {
//    var bbcHTML = try String(contentsOfURL: bbcURL)
//} catch {}

var names:[AnyObject] = ["Bob", "Paul", "Mike", "Betty", "Frank"]
var person:Dictionary<String, String> = ["surname": "Baird", "forename": "Leon"]

names[2]
person["forename"]
names.count

var nameList = [String]()
nameList.append("Frank")
nameList.append("Betty")

// casting

let intString = "42"
let intValue = Int(intString)

let firstName = names[0] as! String

let castNames = names as! [String]

for name in names as! [String] {
    print("The user name is " + name)
    print("The user name is \(name)")
}

for i in 0...1000 {
    sin(Double(i)/100)
    print("Value is \(sin( Double(i) ))")
}

// optionals

var myOptional:Int?

if myOptional == nil {
    // setup code
    print("Needs Setup")
} else {
    print("Already set up and is \(myOptional!)")
}

if let value = myOptional {
    print("Value exists \(value)")
} else {
    print("Do something else")
}

myOptional?.distanceTo(10)

let value = names[0] as! String

if let value = names[0] as? String {
    
}

var myAutoUnwrap:String!











