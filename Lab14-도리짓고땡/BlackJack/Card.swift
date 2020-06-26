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
        self.value = temp%4 + 1
        self.x = temp / 4
        self.suit = ""
    }
    
    func getValue()->Int{
        
        return self.value
        
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
    func getX()->Int{
        return self.x + 1
    }
    func filename()->String{
        return String(self.x + 1) + String(self.value) + ".jpg"
    }
}
