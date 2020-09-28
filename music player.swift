//
//  music player.swift
//  Blackjackk copy6
//
//  Created by Joe Curran on 26/06/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

class MusicPlayer {
static let shared = MusicPlayer()
    
 

    
    /*

     func startBackgroundMusic() {

    if let bundle = Bundle.main.path(forResource: "playlistbj", ofType: "mp3") {
      let backgroundMusic = NSURL(fileURLWithPath: bundle)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
            guard let audioPlayer = audioPlayer else {return}
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print(error)
        }}
    }
    
 */
 
 
 
//@IBOutlet var button: UIButton!
    
   // var audioPlayer: AVAudioPlayer?

    //override func viewDidLoad() {super.viewDidLoad()
        // Do any additional setup after loading the view.
    

@objc func didTapButton(){
        if let player = audioPlayer, player.isPlaying{
            //stop playback
            button.setTitle("play", for: .normal)
            player.pause()
        }
        else {
            //set up player, and play
            button.setTitle("pause", for: .normal)
            let urlString = Bundle.main.path(forResource: "playlistbj", ofType: "mp3")
            
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
               audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = audioPlayer else{
                    return
                }
                
                player.play()
            }
            catch {
                print ("oops")
            }
        }
        
    }
    

}


/*

     func handleInterruption(notification: Notification){
        
        guard let userInfo = notification.userInfo,
            let typeInt = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt else{return}
        guard let type = AVAudioSession.InterruptionType(rawValue: typeInt) else {return}
    
        switch type{
            
        case .began:
            print("began")
            //player is paused and session is in active need to update UI
            audioPlayer?.pause()
            print("audio paused")
            
        default:
            print("ended")
            /**/
            if let optionInt = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionInt)
                if options.contains(.shouldResume){}}


}
}




 
 
 
 
func handleInterruption(notification: NSNotification) {
print("handleInterruption")
guard let value = (notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? NSNumber)?.unsignedIntegerValue,
let interruptionType =  AVAudioSessionInterruptionType(rawValue: value)
else {
print("notification.userInfo?[AVAudioSessionInterruptionTypeKey]", notification.userInfo?[AVAudioSessionInterruptionTypeKey])
return }
switch interruptionType {
case .Began:
print("began")
            audioPlayer.pause()
print("audioPlayer.playing", audioPlayer.playing)
/**/
do {
try theSession.setActive(false)
print("AVAudioSession is inactive")
            } catch let error as NSError {
print(error.localizedDescription)
            }
/**/
// player is paused and session is inactive. need to update UI)
        default :
print("ended")
if let optionValue = (notification.userInfo?[AVAudioSessionInterruptionOptionKey] as? NSNumber)?.unsignedIntegerValue where AVAudioSessionInterruptionOptions(rawValue: optionValue) == .ShouldResume {
print("should resume")
// ok to resume playing, re activate session and resume playing
                /**/
do {
try theSession.setActive(true)
print("AVAudioSession is Active again")
                    player.play()
                } catch let error as NSError {
print(error.localizedDescription)
                }
/**/
// need to update UI
                
//player.play()
            }
        }
    }
 
 
 
 
 















 */
