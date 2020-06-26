//
//  ViewController.swift
//  BlackJack
//
//  Created by KPUGAME on 5/14/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var player: Player = Player(name: "player")
    var dealer: Player = Player(name: "dealer")
    
    var LCardsPlayer = [UIImageView]()
    var LCardsDelaer = [UIImageView]()
    
    var deck = [Int]()
    var deckIndex = 0
    
    var VbetMoney : Int = 0
    var VplayerMoney : Int = 1000
    var nCardsDealer : Int = 0
    var nCardsPlayer : Int = 0
    var isDealerCardClose : Int = 0
    
    @IBOutlet weak var dealerPts: UILabel!
    @IBOutlet weak var playerPts: UILabel!
    @IBOutlet weak var betMoney: UILabel!
    @IBOutlet weak var playerMoney: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var Outlet_Bet50: UIButton!
    @IBOutlet weak var Outlet_Bet25: UIButton!
    @IBOutlet weak var Outlet_Bet10: UIButton!
    @IBOutlet weak var Outlet_Hit: UIButton!
    @IBOutlet weak var Outlet_Stand: UIButton!
    @IBOutlet weak var Outlet_Deal: UIButton!
    @IBOutlet weak var Outlet_Again: UIButton!
    
    @IBAction func Bet50(_ sender: Any) {
        VbetMoney += 50;
        if VbetMoney <= VplayerMoney{
            betMoney.text = "$\(VbetMoney)"
            VplayerMoney -= 50;
            playerMoney.text = "You have $\(VplayerMoney)";
            
            Outlet_Deal.isEnabled = true;
            audioController.playerEffect(name: SoundChip)
        }
        else{
            VbetMoney -= 50;
        }
    }
    @IBAction func Bet25(_ sender: Any) {
        VbetMoney += 25;
               if VbetMoney <= VplayerMoney{
                   betMoney.text = "$\(VbetMoney)"
                   VplayerMoney -= 25;
                   playerMoney.text = "You have $\(VplayerMoney)";
                   
                   Outlet_Deal.isEnabled = true;
                   audioController.playerEffect(name: SoundChip)
               }
               else{
                   VbetMoney -= 25;
               }
    }
    @IBAction func Bet10(_ sender: Any) {
        VbetMoney += 10;
               if VbetMoney <= VplayerMoney{
                   betMoney.text = "$\(VbetMoney)"
                   VplayerMoney -= 10;
                   playerMoney.text = "You have $\(VplayerMoney)";
                   
                   Outlet_Deal.isEnabled = true;
                   audioController.playerEffect(name: SoundChip)
               }
               else{
                   VbetMoney -= 10;
               }
    }
    
    @IBAction func Hit(_ sender: Any) {
        nCardsPlayer += 1
        hitPlayer(n: nCardsPlayer)
        if(player.value() > 21){
            checkWinner()
            Outlet_Bet50.isEnabled = false
            Outlet_Bet25.isEnabled = false
            Outlet_Bet10.isEnabled = false
            Outlet_Hit.isEnabled = false
            Outlet_Stand.isEnabled = false
            Outlet_Deal.isEnabled = false
            Outlet_Again.isEnabled = true
            return
        }
        if dealer.value() < 17{
            nCardsDealer += 1
            hitDealer(n: nCardsDealer)
        }
    }
    @IBAction func Deal(_ sender: Any) {
        deal()
    }
    @IBAction func Stand(_ sender: Any) {
        if dealer.value() < 17{
            nCardsDealer += 1
            hitDealer(n: nCardsDealer)
        }
        else
        {
            checkWinner()
            Outlet_Bet50.isEnabled = false
            Outlet_Bet25.isEnabled = false
            Outlet_Bet10.isEnabled = false
            Outlet_Hit.isEnabled = false
            Outlet_Stand.isEnabled = false
            Outlet_Deal.isEnabled = false
        }
    }
    @IBAction func Again(_ sender: Any) {
        dealerPts.text = "Dealer: " + String(dealer.value())
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
        Outlet_Bet50.isEnabled = true
        Outlet_Bet25.isEnabled = true
        Outlet_Bet10.isEnabled = true
        Outlet_Again.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Outlet_Hit.isEnabled = false
        Outlet_Stand.isEnabled = false
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = false
        
        for i in 0...51{
            deck.append(i)
        }
        
        // Do any additional setup after loading the view.
    }
    var audioController: AudioController
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        super.init(coder: aDecoder)
    }
    
    func deal(){
        deck.shuffle()
        deckIndex = 0
        
        player.reset()
        dealer.reset()
        isDealerCardClose = 0
         
        hitPlayer(n:0)
        hitPlayer(n:1)
        hitDealerDown()
        hitDealer(n:0)
        nCardsPlayer = 1
        nCardsDealer = 0
        
        playerPts.text = "Player: " + String(player.value())
        
        Outlet_Bet50.isEnabled = false
        Outlet_Bet25.isEnabled = false
        Outlet_Bet10.isEnabled = false
        Outlet_Hit.isEnabled = true
        Outlet_Stand.isEnabled = true
        Outlet_Deal.isEnabled = false
        Outlet_Again.isEnabled = true
    }
    func hitDealerDown(){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
        
        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: "b2fv")!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        //오픈 시 삭제 후 할 것self.view.delete(")
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
                       animations: {newImageView.center = CGPoint(x:300,y:250)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        LCardsDelaer.append(newImageView)
        
        dealerPts.text = "Dealer: "
        audioController.playerEffect(name: SoundFlip)
        isDealerCardClose = 1
    }
    func hitDealer(n: Int){
        let newCard = Card(temp:deck[deckIndex])
        deckIndex += 1
        
        dealer.addCard(c: newCard)
        let newImageView = UIImageView(image: UIImage(named: newCard.filename())!)
        newImageView.center = CGPoint(x:500,y:150)
        
        self.view.addSubview(newImageView)
        
        UIView.animate(withDuration: 0.5,delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut,
                       animations: {newImageView.center = CGPoint(x:300+(n+self.isDealerCardClose)*50,y:250)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        LCardsDelaer.append(newImageView)
        
        dealerPts.text = "Dealer: "
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
            animations: {newImageView.center = CGPoint(x:300+n*50,y:450)
                newImageView.transform = CGAffineTransform(rotationAngle: 3.14)
        },completion: nil)
        LCardsPlayer.append(newImageView)
        
        playerPts.text = "Player: " + String(player.value())
        audioController.playerEffect(name: SoundFlip)
    }
    
    func checkWinner(){
        LCardsDelaer[0].removeFromSuperview()
        let newImageView = UIImageView(image:UIImage(named: dealer.cards[0].filename())!)
        
        newImageView.center = CGPoint(x:300,y:250)
        
        self.view.insertSubview(newImageView, belowSubview: LCardsDelaer[1])
        LCardsDelaer[0] = newImageView
        
        dealerPts.text = "Dealer: " + String(dealer.value())
        
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
        VbetMoney = 0
        playerMoney.text = "You have $"+String(VplayerMoney)
        betMoney.text = "$"+String(VbetMoney)
        
        Outlet_Again.isEnabled = true
    }

}

