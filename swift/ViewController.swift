//  ViewController.swift

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.redColor()
        print("LOADED")
        
        doStuff()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doStuff() {
        
        // SWITCH
        var char:String = "A"
        switch (char) {
        case "A":
            println("char == A");
        case "B":
            println("char == B");
        default:
            println("unknown value");
        }
        
        
        // DO WHILE
        var len:Int = 0
        var i:Int = 0
        do {
            println("i: \(i)")
            ++i
        } while (i<len)
        
        
        // WHILE
        var length:Int = 5
        var j:Int = 0
        while (j<len) {
            println("j: \(j)")
            ++j
        }
        
        
        // FOR
        for (i=0; i<len; ++i) {
            println("i: \(i)")
            if (i==2) {
                break; // stop early
            }
        }
        
        
        // FOR-IN
        var stringList:Array = ["A","B","C","D","E"]
        for (index, value) in enumerate(stringList) {
            if (index==1) {
                continue; // skip
            }
            println("\(index) = \(value)")
        }
        
        
        // FUNCTION - BASIC
        func printHelloWorld (Void) -> Void { // declaration / definition
            println("Hello World")
        }
        
        printHelloWorld() // call
        
        
        // FUNCTION PARAMS AND RETURN
        func addIntegers (let integer a:Int,let toInteger b:Int) -> Int {
            var added:Int;
            added = a + b
            return added
        }
        
        var numberA:Int = 4;
        var numberB:Int = 5;
        var numberC:Int = addIntegers(integer:numberA, toInteger:numberB)
        
        
        // FUNCTIONS AS VARIABLES
        var functionVariable:(Int,Int)->Int = addIntegers
        var result:Int = functionVariable(1,2)
        
        
        // PASS BY REFERENCE
        func addIntegersByReference (inout result c:Int, inout integer a:Int, inout toInteger b:Int) -> Void {
            c = a + b
            a = 0
            b = 0
        }
        var localA:Int = 0, localB:Int = 1, localC:Int = 2
        addIntegersByReference(result: &localC, integer: &localA, toInteger: &localB)
        
        
    }

}

