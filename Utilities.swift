//
//  Utilities.swift
//  Blackjackk
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.




import Foundation

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}

