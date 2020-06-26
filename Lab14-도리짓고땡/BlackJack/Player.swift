//
//  Player.swift
//  BlackJack
//
//  Created by KPUGAME on 5/14/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import Foundation
class Player {
    var cards = [Card]()
    
    private var N: Int = 0
    private var name: String
    
    init(name: String){
        self.name = name
    }
    func inHand()->Int{
        return self.N
    }
    func addCard(c: Card){
        cards.append(c)
        self.N += 1
    }
    func reset(){
        self.N = 0
        cards.removeAll()
    }
    func value()->Int{  //카드점수 계산 Ace 1혹은 11으로 모두 사용될 수 있음
        //일단 11으로 계산한 후 21이 넘어가면 1로 다시 계산한다.
        var total: Int = 0//점수 변수
        var ace: Int = 0 // Ace카드 개수 변수
        
        return total
    }
}
