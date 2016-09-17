//  Fibonacci Sequence Playground using recursion
//
//  Created by Ryan Grier on 03/01/16.
//  Copyright © 2016 Ryan Grier All rights reserved.


import UIKit

let knownFibonacciValues: [Int] = [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811 ]

func fibonacciAtIndex(_ index: Int) -> Int {
    guard index >= 2 else {
        return index
    }
    
    return fibonacciAtIndex(index - 1) + fibonacciAtIndex(index - 2)
}

func confirmSequence() -> Bool {
    var valid = true
    
    for (index, fibonacci) in knownFibonacciValues.enumerated() {
        let test = fibonacciAtIndex(index)
        
        if (test != fibonacci) {
            print("Confimation failed at \(index). test: \(test); expected: \(fibonacci)")
            valid = false
            break
        }
    }
    
    return valid
}

fibonacciAtIndex(20)
knownFibonacciValues.count

let start = Date()
//confirmSequence()
let end = Date()
