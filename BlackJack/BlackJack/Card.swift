//
//  Card.swift
//  BlackJack
//
//  Created by KPUGAME on 5/14/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import Foundation
class Card{
    private var value: Int;
    private var x: Int;
    private var suit: String;
    
    init(temp:Int){
        self.value = temp%13 + 1
        self.x = temp / 13
        self.suit = ""
    }
    
    func getValue()->Int{
        if (self.value > 10){
            return 10
        }
        else{
            return self.value
        }
    }
    func getsuit()->String{
        if(x==0){
            self.suit = "Clubs"
        }else if (x==1){
            self.suit = "Spades"
        }else if(x==2){
            self.suit = "Hearts"
        }else{
            self.suit = "Diamonds"
        }
        return self.suit
    }
    
    func filename()->String{
        return getsuit() + String(self.value)
    }
}
