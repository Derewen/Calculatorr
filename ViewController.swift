//
//  ViewController.swift
//  Calculatorr
//
//  Created by Standa Sučanský on 26/10/15.
//  Copyright © 2015 Standa Sučanský. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var lbNum: UILabel!
    
    var butSound: AVAudioPlayer!
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = ""
    }
    
    var leftSide: String = ""
    var rightSide: String = ""
    var runningNumber: String = ""
    var result: String = ""
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
        playSound()
        
        runningNumber += "\(but.tag)"
        lbNum.text = runningNumber
    }
    
    @IBAction func OnDividePress(sender: AnyObject) {
        proccesOperation(Operation.Divide)
    }
    
    @IBAction func OnMultiplyPress(sender: AnyObject) {
        proccesOperation(Operation.Multiply)
    }
    
    @IBAction func OnSubstractPress(sender: AnyObject) {
        proccesOperation(Operation.Substract)
    }
    
    @IBAction func OnAddPress(sender: AnyObject) {
        proccesOperation(Operation.Add)
    }
    
    @IBAction func OnEqualPress(sender: AnyObject) {
        proccesOperation(currentOperation)
    }
    
    func proccesOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != "" {
            //Do math
            rightSide = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftSide)!  * Double(rightSide)!)"
            }
            else if currentOperation == Operation.Divide {
                result = "\(Double(leftSide)! / Double(rightSide)!)"
            }
            else if currentOperation == Operation.Add {
                result = "\(Double(leftSide)! + Double(rightSide)!)"
            }
            else if currentOperation == Operation.Substract {
                result = "\(Double(leftSide)! - Double(rightSide)!)"
            }
            
            leftSide = result
            lbNum.text = result
            }
            
            currentOperation = op
            
        } else {
            //First time operator being pressed
            leftSide = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound(){
        if butSound.playing {
        butSound.stop()
        }
        
        butSound.play()
    }
}

