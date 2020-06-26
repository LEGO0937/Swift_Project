//
//  ViewController.swift
//  BlackJack
//
//  Created by KPUGAME on 5/14/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var score = ["StraightFlush" : 8, "FourOfKind" : 7, "FullHouse" : 6, "Flush" : 5, "Straight" : 4
        ,"ThreeOfAKind" : 3, "TwoPair" : 2, "OnePair" : 1, "None" : 0]
    
    var player: Player = Player(name: "player")
    var dealer: Player = Player(name: "dealer")
    var community : Player = Player(name: "community")
    var LCardsPlayer = [UIImageView]()
    var LCardsDelaer = [UIImageView]()
    var LCardsCommunity = [UIImageView]()
    
    var deck = [Int]()
    var deckIndex = 0
    
    var VbetMoney : Int = 10
    var VplayerMoney : Int = 1000
    var nState : Int = 0  //카드 진행 수
    
    @IBOutlet weak var dealerPts: UILabel!
    @IBOutlet weak var playerPts: UILabel!
    @IBOutlet weak var betMoney: UILabel!
    @IBOutlet weak var playerMoney: UILabel!
    @IBOutlet weak var status: UILabel!
    
   
    
    @IBOutlet weak var Outlet_BetX2: UIButton!
    @IBOutlet weak var Outlet_BetX1: UIButton!
    @IBOutlet weak var Outlet_Check: UIButton!
    @IBOutlet weak var Outlet_Deal: UIButton!
    @IBOutlet weak var Outlet_Again: UIButton!
    
    
    
    
    @IBAction func Check(_ sender: Any) {
        if nState == 3{
            checkWinner();
            nState = 0
            Outlet_Check.isEnabled = false
            Outlet_BetX1.isEnabled = false
            Outlet_BetX2.isEnabled = false
            
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = true

        }
        else{
            Outlet_Check.isEnabled = false
            Outlet_BetX1.isEnabled = false
            Outlet_BetX2.isEnabled = false
            
            Outlet_Deal.isEnabled = true
            Outlet_Again.isEnabled = false
        }
    }
    
    @IBAction func BetX1(_ sender: Any) {
        VbetMoney *= 2;
        if (VbetMoney <= VplayerMoney){
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= (VbetMoney/2)
            playerMoney.text = "You have $\(VplayerMoney)"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        }else{
            VbetMoney /= 2;
        }
        if nState == 3{
            checkWinner();
            nState = 0
            Outlet_Check.isEnabled = false
            Outlet_BetX1.isEnabled = false
            Outlet_BetX2.isEnabled = false
            
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = true

        }
        else{
            Outlet_Check.isEnabled = false
            Outlet_BetX1.isEnabled = false
            Outlet_BetX2.isEnabled = false
            
            Outlet_Deal.isEnabled = true
            Outlet_Again.isEnabled = false
        }
    }
    @IBAction func BetX2(_ sender: Any) {
        VbetMoney *= 3;
        if (VbetMoney <= VplayerMoney){
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= (VbetMoney/3*2)
            playerMoney.text = "You have $\(VplayerMoney)"
            
            Outlet_Deal.isEnabled = true
            audioController.playerEffect(name: SoundChip)
        }else{
            VbetMoney /= 3;
        }
        if nState == 3{
            checkWinner();
            nState = 0
            Outlet_Check.isEnabled = false
            Outlet_BetX1.isEnabled = false
            Outlet_BetX2.isEnabled = false
            
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = true

        }
        else{
            Outlet_Check.isEnabled = false
            Outlet_BetX1.isEnabled = false
            Outlet_BetX2.isEnabled = false
            
            Outlet_Deal.isEnabled = true
            Outlet_Again.isEnabled = false
        }
    }
    @IBAction func Deal(_ sender: Any) {
        deal()
    }
    
    @IBAction func Again(_ sender: Any) {
        initialize()
        Outlet_Again.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...51{
            deck.append(i)
        }
        
        initialize()
        // Do any additional setup after loading the view.
    }
    var audioController: AudioController
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        super.init(coder: aDecoder)
    }
    func initialize()
    {
        deck.shuffle()
        deckIndex = 0
        
        player.reset()
        dealer.reset()
        community.reset()
        
        dealerPts.text = ""
        playerPts.text = ""
        status.text = ""
        betMoney.text = "$10"
        VbetMoney = 10
        
        if LCardsDelaer.count > 0{
            for i in 0...LCardsDelaer.count-1{
                LCardsDelaer[i].removeFromSuperview()
            }
            LCardsDelaer.removeAll()
        }
        if LCardsPlayer.count > 0{
            for i in 0...LCardsPlayer.count-1{
                LCardsPlayer[i].removeFromSuperview()
            }
            LCardsPlayer.removeAll()
        }
        if LCardsCommunity.count > 0{
            for i in 0...LCardsCommunity.count-1{
                LCardsCommunity[i].removeFromSuperview()
            }
            LCardsCommunity.removeAll()
        }
        
        Outlet_Check.isEnabled = true
        Outlet_BetX1.isEnabled = true
        Outlet_BetX2.isEnabled = true
        
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = false
    }
    func deal(){
        if nState == 0{
            hitPlayer(n:0)
            hitPlayer(n:1)
                   //hitDealerDown()
            hitDealer(n:0)
            hitDealer(n:1)
            
            hitCommunity(n: 0)
            hitCommunity(n: 1)
            hitCommunity(n: 2)
        }
        else{
            hitCommunity(n: 2+nState)
        }
        
        nState += 1
        //playerPts.text = "Player: " + String(player.value())
        
        Outlet_Check.isEnabled = true
        Outlet_BetX1.isEnabled = true
        Outlet_BetX2.isEnabled = true
        
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = false
    }
    func hitDealer(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
        
        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: "b2fv")!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
                       animations: {newImageView.center = CGPoint(x:150+n*50,y:250)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        LCardsDelaer.append(newImageView)
        
        audioController.playerEffect(name: SoundFlip)
    }
    func hitPlayer(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
        
        player.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename())!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {newImageView.center = CGPoint(x:150+n*50,y:450)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        LCardsPlayer.append(newImageView)
        audioController.playerEffect(name: SoundFlip)
    }
    
    func hitCommunity(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
        
        community.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename())!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {newImageView.center = CGPoint(x:400+n*50,y:350)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        LCardsCommunity.append(newImageView)
        audioController.playerEffect(name: SoundFlip)
    }
    
    func checkWinner(){
        LCardsDelaer[0].removeFromSuperview()
        let newImageView = UIImageView(image:UIImage(named: dealer.cards[0].filename())!)
        
        newImageView.center = CGPoint(x:150,y:250)
        
        self.view.insertSubview(newImageView, belowSubview: LCardsDelaer[1])
        LCardsDelaer[0] = newImageView
        
        
        LCardsDelaer[1].removeFromSuperview()
        let newImageView2 = UIImageView(image:UIImage(named: dealer.cards[1].filename())!)
        
        newImageView2.center = CGPoint(x:200,y:250)
        self.view.insertSubview(newImageView2, aboveSubview: LCardsDelaer[1])
        LCardsDelaer[1] = newImageView2
        
        
        var dealerPt1 : String = ""
        var playerPt1 : String = ""
        
        dealerPt1 = getResult(ar: community.cards, card1: dealer.cards[0], card2: dealer.cards[1])
        playerPt1 = getResult(ar: community.cards, card1: player.cards[0], card2: player.cards[1])
        
        dealerPts.text = "Dealer: " + dealerPt1
        playerPts.text = "Player: " + playerPt1
       
        let playerPn : String = String(playerPt1.split(separator: " ")[0] )
        let dealerPn : String = String(dealerPt1.split(separator: " ")[0] )
        var dealerPt2 : String = "None"
        var playerPt2 : String = "None"
        if dealerPt1 != "None"{
            dealerPt2 = String(dealerPt1.split(separator: " ")[1] )
        }
        if playerPt1 != "None"{
            playerPt2 = String(playerPt1.split(separator: " ")[1] )
        }
        var num1 : Int = score[playerPn]!
        var num2 : Int = score[dealerPn]!
        
        if num1 > num2{
            VplayerMoney += VbetMoney * 2
            audioController.playerEffect(name: SoundWin)
            status.text = "Win"
        }else if num1 < num2{
            audioController.playerEffect(name: SoundLose)
            status.text = "Lose"
        }else{
            if playerPt2 == "None"{
                num1 = 0
            }
            else{
            num1 = Int(playerPt2)!
            }
            if dealerPt2 == "None"{
                num2 = 0
            }
            else{
                num2 = Int(dealerPt2)!
            }
            if num1 > num2{
                VplayerMoney += VbetMoney * 2
                audioController.playerEffect(name: SoundWin)
                status.text = "Win"
            }else if num1 < num2{
                audioController.playerEffect(name: SoundLose)
                status.text = "Lose"
            }else{
                status.text = "Push"
                VplayerMoney += VbetMoney
            }
        }
        
        /*
        if player.value() > 21{
            status.text = "Player Busts"
            audioController.playerEffect(name: SoundLose)
        }else if dealer.value() > 21{
            status.text = "Dealer Busts"
            VplayerMoney += VbetMoney * 2
            audioController.playerEffect(name: SoundWin)
        }else if dealer.value() == player.value(){
            status.text = "Push"
            VplayerMoney += VbetMoney
        }else if dealer.value() < player.value(){
            status.text = "You won!"
            VplayerMoney += VbetMoney * 2
            audioController.playerEffect(name: SoundWin)
        }else{
            status.text = "Sorry you lost!"
            audioController.playerEffect(name: SoundLose)
        }
        */
        VbetMoney = 0
        playerMoney.text = "You have $"+String(VplayerMoney)
        betMoney.text = "$"+String(VbetMoney)
        
        Outlet_Again.isEnabled = true
    }
    func getResult(ar: [Card], card1: Card, card2: Card)-> String{
        var s : [Card] = []
        s = ar
        s.append(card1)
        s.append(card2)
        
        var straight : Bool = false
        var flush : Bool = false
        var FoK : Bool = false
        var ToK : Bool = false
        
        var numPair : Int = 0
        
        s.sort(by: {$0.getValue() > $1.getValue()})
        
        //straight check
        var straightCounter : Int = 0
        var straightNum : Int = 0 //stratight때의 최소 숫자
        //내림차순 가정
        for i in 1...6{
            if s[i].getValue()+1 == s[i-1].getValue(){
                straightCounter+=1
                if straightCounter == 4
                {
                    straight = true
                    straightNum = s[i].getValue()
                }
            }
            else{
                straightCounter = 0
            }
        }
        /*
        if straightCounter == 4{
            straight = true
            if s[0].getValue() == 1 {
                royal = true
            }
        }else if straightCounter == 3 && s[0].getValue() == 1 &&
            s[1].getValue() == 5{
            straight = true
        }
        */
        //flush check
        var flushNum : Int = 0
        var flushNums : [Int] = [0,0,0,0]
        var flushCounters : [Int] = [0,0,0,0]
        for i in 0..<7{
                flushCounters[s[i].getX()] += 1
                if flushNums[s[i].getX()] < s[i].getValue(){
                    flushNums[s[i].getX()] = s[i].getValue()
                }
        }
        for i in 0..<4{
        if flushCounters[i] >= 5{
            flush = true
            flushNum = flushNums[i]
            }
        }
        //same num check
        var numRanks : [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        for i in 0...6{
            numRanks[s[i].getValue()] += 1
        }
        
        var tokNum : Int = 0
        var fourNum : Int = 0
        var pairNum : Int = 0
        for i in 1...13{
            switch numRanks[i] {
            case 2:
                numPair += 1
                if pairNum < i{
                    pairNum = i
                }
                break
            case 3:
                ToK = true
                if tokNum < i{
                    tokNum = i
                }
                break
            case 4:
                FoK = true
                if fourNum < i{
                    fourNum = i
                }
                break
            default:
                break
            }
        }
        
        if(straight && flush)
        {
            return "StraightFlush" + " " + String(flushNum)
        }else if(FoK){
            return "FourOfKind" + " " + String(fourNum)
        }else if(ToK&&numPair==1){
            return "FullHouse" + " " + String(tokNum)
        }else if(flush){
            return "Flush" + " " + String(flushNum)
        }else if(straight){
            return "Straight" + " " + String(straightNum)
        }else if(ToK){
            return "ThreeOfAKind" + " " + String(tokNum)
        }else if(numPair==2){
            return "TwoPair" + " " + String(pairNum)
        }else if(numPair==1){
            return "OnePair" + " " + String(pairNum)
        }
        
        return "None"
    }
}

