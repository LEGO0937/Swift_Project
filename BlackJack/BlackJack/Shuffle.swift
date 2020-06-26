//
//  Shuffle.swift
//  BlackJack
//
//  Created by KPUGAME on 5/14/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import Foundation
extension Array{
    mutating func shuffle(){
        if count < 2 {return}
        for i in 0..<(count - 1){
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j{
                self.swapAt(i,j)
            }
        }
    }
}
