//
//  ViewController.swift
//  Calculatorr
//
//  Created by Standa Sučanský on 26/10/15.
//  Copyright © 2015 Standa Sučanský. All rights reserved.
//

import UIKit
import AVFoundation
import Darwin

class ViewController: UIViewController {
    
    @IBOutlet weak var lbNum: UILabel!
    
    var butSound: AVAudioPlayer!
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = ""
        case Equals = "="
    }
    
    var firstNumber: String = ""
    var secondNumber: String = ""
    var currentNumber: String = ""
    var result: String = ""
    let dmax = DBL_MAX
    
    var currentOperation: Operation = Operation.Empty
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try butSound = AVAudioPlayer(contentsOfURL: soundUrl)
            butSound.prepareToPlay()
        } catch let err as NSError{
        print(err.debugDescription)
        }
    }
    
    @IBAction func OnNumberPress(but: UIButton!){
        butSound.play()
        
        if lbNum.text == result {
        currentNumber = "\(but.tag)"
        }
        else {
            currentNumber += "\(but.tag)"
        }
        lbNum.text = currentNumber
    }
    
    @IBAction func OnDividePress(sender: AnyObject) {
        currentOperation = Operation.Divide
        doOperation(currentOperation)
    }
    
    @IBAction func OnMultiplyPress(sender: AnyObject) {
        currentOperation = Operation.Multiply
        doOperation(currentOperation)
    }
    
    @IBAction func OnSubstractPress(sender: AnyObject) {
        currentOperation = Operation.Substract
        doOperation(currentOperation)
    }
    
    @IBAction func OnAddPress(sender: AnyObject) {
        currentOperation = Operation.Add
        doOperation(currentOperation)
    }
    
    @IBAction func OnEqualPress(sender: AnyObject) {
        doOperation(Operation.Equals)
    }
    
    
    func doOperation(operation: Operation) {
        
        if currentNumber == "" {
            currentOperation = Operation.Empty
        } else if firstNumber == "" {
            firstNumber = currentNumber
            currentNumber = ""
        } else if currentOperation == Operation.Empty {
            currentOperation = operation
        } else if secondNumber == "" {
            secondNumber = currentNumber
            currentNumber = ""
        }
        
        if firstNumber != "" && secondNumber != "" {
            math(currentOperation)
            firstNumber = ""
            secondNumber = ""
            currentNumber = result
            lbNum.text = result
        }
        
    }
    
    
    func math(op: Operation) {
        if op == Operation.Multiply {
            result = "\(Double(firstNumber)!  * Double(secondNumber)!)"
        }
        else if op == Operation.Divide {
            result = "\(Double(firstNumber)! / Double(secondNumber)!)"
        }
        else if op == Operation.Add {
            result = "\(Double(firstNumber)! + Double(secondNumber)!)"
        }
        else if op == Operation.Substract {
            result = "\(Double(firstNumber)! - Double(secondNumber)!)"
        }
        else if op == Operation.Equals {
            
        }
    }
}

