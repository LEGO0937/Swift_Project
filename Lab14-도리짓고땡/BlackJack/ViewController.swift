//
//  ViewController.swift
//  BlackJack
//
//  Created by KPUGAME on 5/14/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var score = ["118" : "콩콩팔", "127" : "삐리칠", "136" : "물삼육", "145" : "빽새오", "1910" : "삥구장", "226" : "니니육", "235" : "이삼오", "2810" : "이판장", "334" : "심심새", "3710" : "삼칠장"
        ,"389" : "삼빡구", "442" : "살살이", "4610" : "사륙장", "479" : "사칠구", "5510" : "꼬꼬장", "569" : "오륙구", "578" : "오리발", "668" : "쭉쭉팔", "776" : "철철육", "884" : "팍팍싸", "992" : "구구리"]
    
    var fillter = ["노메이드" : 0, "망통" : 1, "1끗" : 2, "2끗" : 3, "3끗": 4, "4끗" : 5, "5끗" : 6, "6끗" : 7, "7끗" : 8, "8끗" : 9, "삥땡" : 10, "이땡" : 11, "삼땡" : 12, "사땡" : 13, "오땡" : 14, "육땡" : 15, "칠땡" : 16, "팔땡" : 17, "구땡" : 18, "장땡" : 19, "18광땡" : 20, "13광땡" : 20, "38광땡" : 21]
    var player1: Player = Player(name: "player1")
    var player2: Player = Player(name: "player2")
    var player3: Player = Player(name: "player3")
    
    var dealer: Player = Player(name: "dealer")
    
    var LCardsPlayer1 = [UIImageView]()
    var LCardsPlayer2 = [UIImageView]()
    var LCardsPlayer3 = [UIImageView]()
    var LCardsDelaer = [UIImageView]()
   
    var deck = [Int]()
    var deckIndex = 0
    
    var betMoney1 : Int = 0
    var betMoney2 : Int = 0
    var betMoney3 : Int = 0
    var playerMoney : Int = 1000
    
    var Hwatoo1 = [UILabel]()
    var Hwatoo2 = [UILabel]()
    var Hwatoo3 = [UILabel]()
    var Hwatoo4 = [UILabel]()
    
    @IBOutlet weak var H10: UILabel!
    @IBOutlet weak var H11: UILabel!
    @IBOutlet weak var H12: UILabel!
    @IBOutlet weak var H13: UILabel!
    @IBOutlet weak var H14: UILabel!
    @IBOutlet weak var H20: UILabel!
    @IBOutlet weak var H21: UILabel!
    @IBOutlet weak var H22: UILabel!
    @IBOutlet weak var H23: UILabel!
    @IBOutlet weak var H24: UILabel!
    @IBOutlet weak var H30: UILabel!
    @IBOutlet weak var H31: UILabel!
    @IBOutlet weak var H32: UILabel!
    @IBOutlet weak var H33: UILabel!
    @IBOutlet weak var H34: UILabel!
    @IBOutlet weak var H40: UILabel!
    @IBOutlet weak var H41: UILabel!
    @IBOutlet weak var H42: UILabel!
    @IBOutlet weak var H43: UILabel!
    @IBOutlet weak var H44: UILabel!
    
    @IBOutlet weak var Outlet_playerPts1: UILabel!
    @IBOutlet weak var Outlet_playerPts2: UILabel!
    @IBOutlet weak var Outlet_playerPts3: UILabel!
    @IBOutlet weak var Outlet_dealerPts: UILabel!
    @IBOutlet weak var Outlet_betMoney1: UILabel!
    @IBOutlet weak var Outlet_betMoney2: UILabel!
    @IBOutlet weak var Outlet_betMoney3: UILabel!
    @IBOutlet weak var Outlet_playerMoney: UILabel!
    
    @IBOutlet weak var Outlet_Bet15: UIButton!
    @IBOutlet weak var Outlet_Bet11: UIButton!
    @IBOutlet weak var Outlet_Bet25: UIButton!
    @IBOutlet weak var Outlet_Bet21: UIButton!
    @IBOutlet weak var Outlet_Bet35: UIButton!
    @IBOutlet weak var Outlet_Bet31: UIButton!
    
    @IBOutlet weak var Outlet_status1: UILabel!
    @IBOutlet weak var Outlet_status2: UILabel!
    @IBOutlet weak var Outlet_status3: UILabel!
    
    @IBOutlet weak var Outlet_Deal: UIButton!
    @IBOutlet weak var Outlet_Again: UIButton!
    
    @IBAction func Bet15(_ sender: Any) {
        Outlet_Deal.isEnabled = true
        betMoney1 += 5
        Outlet_betMoney1.text = String(betMoney1) + "만"
        playerMoney -= 5
        Outlet_playerMoney.text = String(playerMoney) + "만"
    }
    @IBAction func Bet25(_ sender: Any) {
        Outlet_Deal.isEnabled = true
        betMoney2 += 5
        Outlet_betMoney2.text = String(betMoney2) + "만"
        playerMoney -= 5
        Outlet_playerMoney.text = String(playerMoney) + "만"
    }
    @IBAction func Bet35(_ sender: Any) {
        Outlet_Deal.isEnabled = true
        betMoney3 += 5
        Outlet_betMoney3.text = String(betMoney3) + "만"
        playerMoney -= 5
        Outlet_playerMoney.text = String(playerMoney) + "만"
    }
    @IBAction func Bet11(_ sender: Any) {
        Outlet_Deal.isEnabled = true
        betMoney1 += 1
        Outlet_betMoney1.text = String(betMoney1) + "만"
        playerMoney -= 1
        Outlet_playerMoney.text = String(playerMoney) + "만"
    }
    @IBAction func Bet21(_ sender: Any) {
        Outlet_Deal.isEnabled = true
        betMoney2 += 1
        Outlet_betMoney2.text = String(betMoney2) + "만"
        playerMoney -= 1
        Outlet_playerMoney.text = String(playerMoney) + "만"
    }
    @IBAction func Bet31(_ sender: Any) {
        Outlet_Deal.isEnabled = true
        betMoney3 += 1
        Outlet_betMoney3.text = String(betMoney3) + "만"
        playerMoney -= 1
        Outlet_playerMoney.text = String(playerMoney) + "만"
    }
    
    @IBAction func Deal(_ sender: Any) {
        deal()
    }
    @IBAction func Again(_ sender: Any) {
        initialize()
    }
    
    var nState : Int = 0  //카드 진행 수
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...39{
            deck.append(i)
        }
        
        Hwatoo1 = [H10,H11,H12,H13,H14]
        Hwatoo2 = [H20,H21,H22,H23,H24]
        Hwatoo3 = [H30,H31,H32,H33,H34]
        Hwatoo4 = [H40,H41,H42,H43,H44]
        
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
        
        nState = 0
        for i in 0..<5{
            Hwatoo1[i].text = ""
            Hwatoo2[i].text = ""
            Hwatoo3[i].text = ""
            Hwatoo4[i].text = ""
            
            Hwatoo1[i].textColor = UIColor.white
            Hwatoo2[i].textColor = UIColor.white
            Hwatoo3[i].textColor = UIColor.white
            Hwatoo4[i].textColor = UIColor.white
        }
        
        Outlet_status1.textColor = UIColor.orange
        Outlet_status2.textColor = UIColor.orange
        Outlet_status3.textColor = UIColor.orange
        
        self.view.backgroundColor = UIColor.darkGray
        
        player1.reset()
        player2.reset()
        player3.reset()
        dealer.reset()
        
        Outlet_dealerPts.text = ""
        Outlet_playerPts1.text = ""
        Outlet_playerPts2.text = ""
        Outlet_playerPts3.text = ""
        
        Outlet_status1.text = ""
        Outlet_status2.text = ""
        Outlet_status3.text = ""
        
        Outlet_betMoney1.text = "0만"
        Outlet_betMoney2.text = "0만"
        Outlet_betMoney3.text = "0만"

        betMoney1 = 0
        betMoney2 = 0
        betMoney3 = 0
        
        
        if LCardsDelaer.count > 0{
            for i in 0...LCardsDelaer.count-1{
                LCardsDelaer[i].removeFromSuperview()
            }
            LCardsDelaer.removeAll()
        }
        if LCardsPlayer1.count > 0{
            for i in 0...LCardsPlayer1.count-1{
                LCardsPlayer1[i].removeFromSuperview()
            }
            LCardsPlayer1.removeAll()
        }
        if LCardsPlayer2.count > 0{
            for i in 0...LCardsPlayer2.count-1{
                LCardsPlayer2[i].removeFromSuperview()
            }
            LCardsPlayer2.removeAll()
        }
        if LCardsPlayer3.count > 0{
            for i in 0...LCardsPlayer3.count-1{
                LCardsPlayer3[i].removeFromSuperview()
            }
            LCardsPlayer3.removeAll()
        }
       
        
        Outlet_Bet15.isEnabled = false
        Outlet_Bet11.isEnabled = false
        Outlet_Bet25.isEnabled = false
        Outlet_Bet21.isEnabled = false
        Outlet_Bet35.isEnabled = false
        Outlet_Bet31.isEnabled = false
        
        Outlet_Deal.isEnabled = true
        Outlet_Again.isEnabled = false
    }
    func deal(){
        if nState == 0{
            hitPlayer1(n:0)
            
            hitPlayer2(n:0)
            
            hitPlayer3(n:0)
        
            hitDealer(n:0)
        }
        else if nState == 1{
            hitPlayer1(n:1)
            hitPlayer1(n:2)
            hitPlayer1(n:3)
            
            hitPlayer2(n:1)
            hitPlayer2(n:2)
            hitPlayer2(n:3)
            
            hitPlayer3(n:1)
            hitPlayer3(n:2)
            hitPlayer3(n:3)
                   
            hitDealer(n:1)
            hitDealer(n:2)
            hitDealer(n:3)
        }
        else if nState == 2{
            hitPlayer1(n:4)
            
            hitPlayer2(n:4)
           
            hitPlayer3(n:4)
           
            hitDealer(n:4)
            
            checkWinner()
            Outlet_Bet15.isEnabled = false
            Outlet_Bet11.isEnabled = false
            Outlet_Bet25.isEnabled = false
            Outlet_Bet21.isEnabled = false
            Outlet_Bet35.isEnabled = false
            Outlet_Bet31.isEnabled = false
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = true
            
            return
        }
        nState += 1
        //playerPts.text = "Player: " + String(player.value())
        
        Outlet_Bet15.isEnabled = true
        Outlet_Bet11.isEnabled = true
        Outlet_Bet25.isEnabled = true
        Outlet_Bet21.isEnabled = true
        Outlet_Bet35.isEnabled = true
        Outlet_Bet31.isEnabled = true
        
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = false
    }
    func hitDealer(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
        
        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: "cardback.jpg")!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
                       animations: {newImageView.center = CGPoint(x:150+n*30,y:200)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        //Hwatoo4[n].text = String(newCard.getX())
        LCardsDelaer.append(newImageView)
        
        audioController.playerEffect(name: SoundFlip)
    }
    func hitPlayer1(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
        
        player1.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename())!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {newImageView.center = CGPoint(x:50+n*30,y:450)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        Hwatoo1[n].text = String(newCard.getX())
        LCardsPlayer1.append(newImageView)
        audioController.playerEffect(name: SoundFlip)
    }
    func hitPlayer2(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
           
        player2.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename())!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {newImageView.center = CGPoint(x:300+n*30,y:450)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        Hwatoo2[n].text = String(newCard.getX())
        LCardsPlayer2.append(newImageView)
           
        audioController.playerEffect(name: SoundFlip)
       }
    func hitPlayer3(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
           
        player3.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename())!)
        newImageView.center = CGPoint(x:500,y:150)
           
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
            animations: {newImageView.center = CGPoint(x:520+n*30,y:450)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        Hwatoo3[n].text = String(newCard.getX())
        LCardsPlayer3.append(newImageView)
        audioController.playerEffect(name: SoundFlip)
       }
    
    
    func checkWinner(){
        LCardsDelaer[0].removeFromSuperview()
        let newImageView = UIImageView(image:UIImage(named: dealer.cards[0].filename())!)
        
        newImageView.center = CGPoint(x:150,y:200)
        
        self.view.insertSubview(newImageView, belowSubview: LCardsDelaer[1])
        LCardsDelaer[0] = newImageView
        
        
        LCardsDelaer[1].removeFromSuperview()
        let newImageView2 = UIImageView(image:UIImage(named: dealer.cards[1].filename())!)
        
        newImageView2.center = CGPoint(x:180,y:200)
        self.view.insertSubview(newImageView2, aboveSubview: LCardsDelaer[1])
        LCardsDelaer[1] = newImageView2
        
        LCardsDelaer[2].removeFromSuperview()
        let newImageView3 = UIImageView(image:UIImage(named: dealer.cards[2].filename())!)
        
        newImageView3.center = CGPoint(x:210,y:200)
        self.view.insertSubview(newImageView3, aboveSubview: LCardsDelaer[2])
        LCardsDelaer[2] = newImageView3
        
        LCardsDelaer[3].removeFromSuperview()
        let newImageView4 = UIImageView(image:UIImage(named: dealer.cards[3].filename())!)
        
        newImageView4.center = CGPoint(x:240,y:200)
        self.view.insertSubview(newImageView4, aboveSubview: LCardsDelaer[3])
        LCardsDelaer[3] = newImageView4
        
        LCardsDelaer[4].removeFromSuperview()
        let newImageView5 = UIImageView(image:UIImage(named: dealer.cards[4].filename())!)
        
        newImageView5.center = CGPoint(x:270,y:200)
        self.view.insertSubview(newImageView5, aboveSubview: LCardsDelaer[4])
        LCardsDelaer[4] = newImageView5
        
        Hwatoo4[0].text = String(dealer.cards[0].getX())
        Hwatoo4[1].text = String(dealer.cards[1].getX())
        Hwatoo4[2].text = String(dealer.cards[2].getX())
        Hwatoo4[3].text = String(dealer.cards[3].getX())
        Hwatoo4[4].text = String(dealer.cards[4].getX())
        var dealerPt : String
        var player1Pt : String
        var player2Pt : String
        var player3Pt : String
        
        dealerPt = getResult(ar: dealer.cards, labels: Hwatoo4, view: LCardsDelaer)
        player1Pt = getResult(ar: player1.cards, labels: Hwatoo1,view: LCardsPlayer1)
        player2Pt = getResult(ar: player2.cards, labels: Hwatoo2,view: LCardsPlayer2)
        player3Pt = getResult(ar: player3.cards, labels: Hwatoo3,view: LCardsPlayer3)
        
        Outlet_dealerPts.text = dealerPt
        Outlet_playerPts1.text = player1Pt
        Outlet_playerPts2.text = player2Pt
        Outlet_playerPts3.text = player3Pt
        
        
        if player1Pt == "노메이드"
        {
            Outlet_status1.text = "패"
        }else{
            if dealerPt == "노메이드"{
                Outlet_status1.text = "승"
                playerMoney += betMoney1 * 2
            }
            else{
                //값 비교
                let playerScore : String = String(player1Pt.split(separator: " ")[1])
                let dealerScore : String = String(dealerPt.split(separator: " ")[1])
                
                let scoreP : Int = fillter[playerScore]!
                let scoreD : Int = fillter[dealerScore]!
                
                if scoreP > scoreD{
                    Outlet_status1.text = "승"
                    playerMoney += betMoney1 * 2
                }else{
                    Outlet_status1.text = "패"
                }
            }
        }
        
        if player2Pt == "노메이드"
        {
            Outlet_status2.text = "패"
        }else{
            if dealerPt == "노메이드"{
                Outlet_status2.text = "승"
                playerMoney += betMoney2 * 2
            }
            else{
                //값 비교
                let playerScore : String = String(player2Pt.split(separator: " ")[1])
                let dealerScore : String = String(dealerPt.split(separator: " ")[1])
                
                let scoreP : Int = fillter[playerScore]!
                let scoreD : Int = fillter[dealerScore]!
                
                if scoreP > scoreD{
                    Outlet_status2.text = "승"
                    playerMoney += betMoney2 * 2
                }else{
                    Outlet_status2.text = "패"
                }
            }
        }
        
        if player3Pt == "노메이드"
        {
            Outlet_status3.text = "패"
        }else{
            if dealerPt == "노메이드"{
                Outlet_status3.text = "승"
                playerMoney += betMoney3 * 2
            }
            else{
                //값 비교
                let playerScore : String = String(player3Pt.split(separator: " ")[1])
                let dealerScore : String = String(dealerPt.split(separator: " ")[1])
                
                let scoreP : Int = fillter[playerScore]!
                let scoreD : Int = fillter[dealerScore]!
                
                if scoreP > scoreD{
                    Outlet_status3.text = "승"
                    playerMoney += betMoney3 * 2
                }else{
                    Outlet_status3.text = "패"
                }
            }
        }
        Outlet_playerMoney.text = String(playerMoney) + "만"
        /*
        dealerPt1 = getResult(ar: community.cards, card1: dealer.cards[0], card2: dealer.cards[1])
        playerPt1 = getResult(ar: community.cards, card1: player.cards[0], card2: player.cards[1])
        
        dealerPts.text = "Dealer: " + dealerPt1
        playerPts.text = "Player: " + playerPt1
       
        let playerPn : String = String(playerPt1.split(separator: " ")[0] )
        let dealerPn : String = String(dealerPt1.split(separator: " ")[0] )
        let dealerPt2 : String = String(dealerPt1.split(separator: " ")[1] )
        let playerPt2 : String = String(playerPt1.split(separator: " ")[1] )
       
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
            num1 = Int(playerPt2)!
            num2 = Int(dealerPt2)!
            
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
 */
    }
    func getResult(ar: [Card], labels: [UILabel], view: [UIImageView])-> String{
        var s : [Card] = []
        s = ar

        var ddang38 : Bool = false
        var ddangGwang : Bool = false
        var ddang : Bool = false
        var ggut : Bool = false
        var mangtong : Bool = false
        
        //s.sort(by: {$0.getX() < $1.getX()})
        var made : String = "None"
        var made1 : Int = 0
        var made2 : Int = 0
        var made3 : Int = 0
        
        for i in 0..<5{
            if made != "None"{
                break
            }
            for j in 0..<5{
                if made != "None"{
                    break
                }
                if j == i{
                    continue
                }
                for k in 0..<5{
                    if made != "None"{
                        break
                    }
                    if k == j || k == i{
                        continue
                    }
                    
                    made = score[String(s[i].getX())+String(s[j].getX())+String(s[k].getX())] ?? "None"
                    //여기에 적을것
                    if made != "None"{
                        made1 = i
                        made2 = j
                        made3 = k
                        view[i].center.y = view[i].center.y + 30
                        view[j].center.y = view[j].center.y + 30
                        view[k].center.y = view[k].center.y + 30
                    }
                }
            }
        }
        
        if made == "None"{
            return "노메이드"
        }
        labels[made1].textColor = UIColor.orange
        labels[made2].textColor = UIColor.orange
        labels[made3].textColor = UIColor.orange
        
        //s.sort(by: {$0.getX() < $1.getX()})
        var numDdang : String = ""
        var numDdangGwang : String = ""
        var numGgut : Int = 0
        for i in 0..<4{
            for j in i+1..<5{
                if i != made1 && i != made2 && i != made3 && j != made3 && j != made2 && j != made1{
                    if s[i].getValue() == 1 && s[j].getValue() == 1{
                        if (s[i].getX() == 3 && s[j].getX() == 8) || (s[i].getX() == 8 && s[j].getX() == 3){
                            ddang38 = true
                        }
                        else if (s[i].getX() == 1 && s[j].getX() == 8) ||
                            (s[i].getX() == 8 && s[j].getX() == 1){
                            ddangGwang = true
                            numDdangGwang = "18"
                        }
                        else if (s[i].getX() == 3 && s[j].getX() == 1) ||
                            (s[i].getX() == 1 && s[j].getX() == 3){
                            ddangGwang = true
                            numDdangGwang = "13"
                        }
                    }
                    if s[i].getX() == s[j].getX(){
                        ddang = true
                        switch s[i].getX() {
                        case 1:
                            numDdang = "삥땡"
                            break
                        case 2:
                            numDdang = "이땡"
                            break
                        case 3:
                            numDdang = "삼땡"
                            break
                        case 4:
                            numDdang = "사땡"
                            break
                        case 5:
                            numDdang = "오땡"
                            break
                        case 6:
                            numDdang = "육땡"
                            break
                        case 7:
                            numDdang = "칠땡"
                            break
                        case 8:
                            numDdang = "팔땡"
                            break
                        case 9:
                            numDdang = "구땡"
                            break
                        case 10:
                            numDdang = "장땡"
                            break
                            
                        default:
                            break
                        }
                    }
                    else if (s[i].getX() == 2 && s[j].getX() == 8) ||
                        (s[i].getX() == 3 && s[j].getX() == 7) || (s[i].getX() == 8 && s[j].getX() == 2) ||
                        (s[i].getX() == 7 && s[j].getX() == 3)
                    {
                        mangtong = true
                    }
                    else{
                        numGgut = (s[i].getX() + s[j].getX()) % 10
                        if numGgut >= 1 && numGgut <= 8{
                            ggut = true
                        }
                    }
                }
            }
        }
        
        //straight check
        
        
        if(ddang38)
        {
            return made + " " + "38광땡"
        }else if(ddangGwang){
            return made + " " + numDdangGwang + "광땡"
        }else if(ddang){
            return made + " " + numDdang
        }else if(ggut){
            return made + " " + String(numGgut) + "끗"
        }else if(mangtong){
            return made + " " + "망통"
        }
        return "노메이드"
    }
}

