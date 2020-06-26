//
//  AudioController.swift
//  BlackJack
//
//  Created by KPUGAME on 5/14/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import Foundation
import AVFoundation

let SoundFlip = "cardFlip1.wav"
let SoundAgain = "ding.wav"
let SoundLose = "wrong.wav"
let SoundWin = "win.wav"
let SoundChip = "chip.wav"
let AudioEffectFiles = [SoundFlip,SoundAgain,SoundLose,SoundWin,SoundChip]


class AudioController{
    
    private var audio = [String: AVAudioPlayer]()
    
    var player: AVAudioPlayer?
    
    func preloadAudioEffects(audioFileNames: [String]){
        for effect in AudioEffectFiles{
            let soundPath = Bundle.main.path(forResource: effect, ofType: nil)
            let soundURL = NSURL.fileURL(withPath: soundPath!)
            
            do{
                player = try AVAudioPlayer(contentsOf: soundURL)
                guard let player = player else{
                    return
                }
                
                player.numberOfLoops = 0
                player.prepareToPlay()
                
                audio[effect] = player
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func playerEffect(name: String){
        if let player = audio[name]{
            if player.isPlaying{
                player.currentTime = 0
            }else{
                player.play()
            }
        }
    }
}
