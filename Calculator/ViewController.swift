//
//  ViewController.swift
//  Calculator
//
//  Created by Bogdan Sasko on 1/24/18.
//  Copyright © 2018 Bogdan Sasko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var calculatorController = CalculatorController()
    
    @IBOutlet weak var displayLabel: UILabel!
    var userIsInMiddleInTyping = false
    var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text! = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInMiddleInTyping {
            calculatorController.setOperand(operand: displayValue)
            userIsInMiddleInTyping = false
        }
    
        if let mathSymbol = sender.currentTitle {
            calculatorController.performOperation(mathSymbol: mathSymbol)
            displayValue = calculatorController.result
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if (userIsInMiddleInTyping) {
            displayLabel.text! += digit
        } else {
            displayLabel.text! = digit
        }
        userIsInMiddleInTyping = true
    }
}

