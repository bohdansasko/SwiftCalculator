//
//  CalculatorController.swift
//  Calculator
//
//  Created by Bogdan Sasko on 1/24/18.
//  Copyright © 2018 Bogdan Sasko. All rights reserved.
//

import Foundation

enum Optional<T> {
    case None
    case Some(T)
}

func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorController {
    private var accumulator = 0.0
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(Double.pi),
        "e" : Operation.Constant(M_E),
        "C" : Operation.Constant(0.0),
        "±" : Operation.UnaryOperation({ -$0 }),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "√" : Operation.UnaryOperation(sqrt),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    func performOperation(mathSymbol: String) {
        if let operation = operations[mathSymbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function): pendingOperation = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                if pendingOperation != nil {
                    accumulator = pendingOperation!.binaryFunction(pendingOperation!.firstOperand, accumulator)
                }
            }
        }
    }
    
    private var pendingOperation: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator;
        }
    }
}
