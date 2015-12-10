//: Playground - noun: a place where people can play

import UIKit


func doSomething() {
    print("HI")
}

func addValues(valA a:Int, valB b:Int) -> Int {
    return a + b
}

doSomething()


addValues(valA: 10, valB: 10)

func getLots(valA a:Int, valB b:Int) -> (added:Int, mulitplied:Int, divided:Double) {
    return(a+b, a*b, Double(a/b))
}

let example = getLots(valA: 10, valB: 5)

example.divided

func valuesAndClosures(valA a:Int, valB b:Int, callback:(number:Int, text:String)->(Bool)) {
    
    callback(number: a+b, text: "Hi there")
    
}

valuesAndClosures(valA: 10, valB: 20) { (number, text) -> (Bool) in
    return true
}


func exampleClosue(callback:()->() ) {
    
}

exampleClosue { () -> () in
    
}

exampleClosue(doSomething)






