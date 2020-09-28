//
//  musicplayer.swift
//  Blackjackk copy7
//
//  Created by Joe Curran on 09/07/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit
class MusicPlayer {


var bgplayer: AVAudioPlayer?

func startBackgroundMusic(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            bgplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            bgplayer?.numberOfLoops = -1
            bgplayer?.play()
            audioPlayer?.volume = 1.0
            
        }catch {
            print("error")
        }}
    }



func handleInterruption(notification: Notification){
        
        guard let userInfo = notification.userInfo,
            let typeInt = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt else{return}
        guard let type = AVAudioSession.InterruptionType(rawValue: typeInt) else {return}
    
        switch type{
            
        case .began:
            print("began")
            //player is paused and session is in active need to update UI
            bgplayer?.pause()
            print("audio paused")
            
        default:
            print("ended")
            /**/
            if let optionInt = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionInt)
                if options.contains(.shouldResume){}}
}
}






}

