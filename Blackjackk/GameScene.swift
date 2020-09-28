//
//  GameScene.swift
//  Blackjackk
//
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import SpriteKit
                                                                  
import AVFoundation
import Foundation

var audioPlayer:AVAudioPlayer?
var button:UIButton!
var bgplayer:AVAudioPlayer?

enum TableType: String {
    case ovaloffice
    case austin
    case bond
}
extension TableType {
    static func `for`(playerScore: Int) -> TableType {
        switch playerScore {
        case 0...5:
            return .ovaloffice
        case 6...10:
            return .austin
        default:
            return .bond
        }
    }
    var imageName: String {rawValue}
  }

var tableType: TableType = .ovaloffice
var playerScore = 0 {
    didSet(newScore) {
        let newTableType = TableType.for(playerScore: newScore)
        //Call `replaceTable()` only on `tableType` did change
        if tableType != newTableType {
            tableType = newTableType
            
        }
    }
}

class GameScene: SKScene {
    let moneyContainer = SKSpriteNode(color: .clear, size: CGSize(width:250, height: 150))
    let dealBtn = SKSpriteNode(imageNamed: "deal_btn")
    let hitBtn = SKSpriteNode(imageNamed: "hit_btn")
    let standBtn = SKSpriteNode(imageNamed: "stand_btn")
    let instructionText = SKLabelNode(text: "Place your bet")
    let player1 = Player(hand: Hand(),bank: Bank())
    let dealer = Dealer(hand: Hand())
    var allCards = [Card]()
    let dealerCardsY = 830 // Y position of dealer cards was 930
    let playerCardsY = 200 // Y position of player cards
    //let playerCardsX = 300  // new x
    //let dealerCardsX = 300  // new x
    var currentPlayerType:GenericPlayer = Player(hand: Hand(),bank: Bank())
    var playerYields = false
    let deck = Deck()
    let musicPlayer = MusicPlayer()
   // let musicPlayer = MusicPlayer()
  //  var playerScore = 0
    let playerLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    var dealSscore = 0
    let dealerLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")

    //var table = SKSpriteNode(imageNamed: "")
    var currentTable: SKSpriteNode?
    let playerBlackjackSounds = ["looks", "my seat2", "knicks", "daddy money", "cheeto", "whipped"]
    let playerBustSounds = ["mail order", "winning not", "crayon", "on the chin", "move lips ah", "stupid", "food chain", "gooder", "teeth"]
    let dealerBlackjackSounds = ["35 bj", "ping pong", "whitejack", "piss off", "chicken", "can i say", "not whitejack", "blow mouth"]
    let arrayTieSounds = ["knicks", "rig it", "kings", "ping pong", "on the chin", "gooder"]
    let playerLoseSounds = ["stump up pb", "lose to donald", "rig it", "sarcasm", "hooker", "hilarys hand", "kings", "beat ass", "happy meal"]
    let dealerBustSounds = ["be back da", "won again", "leather", "thick b", "my seat", "d duck", "lost conc", "russian"]
    let dealerLoseSounds = ["lose better", "hilary desk", "not ripped", "chunky ass", "easy come", "you win im rich", "loose change", "whipped"]
    
    
    
    
    override func didMove(to view: SKView) {
        setupTable()
        setupButtons()
        currentPlayerType = player1
        //musicPlayer.startBackgroundMusic(sound: "playlistbj", type: "mp3")
        didTapButton()
        }
    
    
    
    
    
    
    func setupTable(){
       
         //   addChild(table)
         //   table.position = CGPoint(x: size.width/2, y: size.height/2)
         //   table.zPosition = -1
        
        replaceTable()
        
        addChild(moneyContainer)
        moneyContainer.anchorPoint = CGPoint(x:0, y:0)
        moneyContainer.position = CGPoint(x:size.width/2 - 125, y:size.height/2)
        instructionText.fontColor = UIColor.red       //UIColor.black
        instructionText.fontName = "AvenirNext-Bold"                     //new code
        addChild(instructionText)
        instructionText.position = CGPoint(x: size.width/2, y: 400)  //(x: size.width/2, y: 400)
        deck.new()
       
       
        playerLabel.text = "Arnie: 0"
        playerLabel.fontSize = 30
        playerLabel.fontColor = SKColor.red
        playerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        playerLabel.position = CGPoint(x: 350, y: 300)  // 350   360
        playerLabel.zPosition = 100
        addChild(playerLabel)

        dealerLabel.text = "Trump: 0"
        dealerLabel.fontSize = 30
        dealerLabel.fontColor = SKColor.red
        dealerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        dealerLabel.position = CGPoint(x: 340, y: 660)  // was 300   660
        dealerLabel.zPosition = 100
        addChild(dealerLabel)
        
    }
    
  
    
    
    
    
    func replaceTable(){
        
        if let table = currentTable{
            table.removeFromParent()
            currentTable = nil
        }
        let table = SKSpriteNode(imageNamed: tableType.imageName)
        addChild(table)
        table.position = CGPoint(x: size.width/2, y: size.height/2)
        //   table.zPosition = -1
  /*      switch tableType {
        case .ovaloffice:
            //...
            break
        case .austin:
            //...
            break
        case .bond:
            //...
            break
       */
        
    }
    
    
    
    
    
    
  func addPlayerScore() {
      
      playerScore += 1
      playerLabel.text = "Arnie: \(playerScore)"
  }
      
      func addDealerScore(){
          
          dealSscore += 1
          dealerLabel.text = "Trump: \(dealSscore)"
      }
 
 
    func setupButtons(){
        dealBtn.name = "dealBtn"
        addChild(dealBtn)
        dealBtn.color = .red
        dealBtn.colorBlendFactor = 0.4
        dealBtn.position = CGPoint(x:250, y:40)  // x was300 cng to 250
        
        
        hitBtn.name = "hitBtn"
        addChild(hitBtn)
        hitBtn.color = .white
        hitBtn.colorBlendFactor = 0.4
        hitBtn.position = CGPoint(x:375, y:40)    // x was 450 chg to 375
        hitBtn.isHidden = true
        
        standBtn.name = "standBtn"
        addChild(standBtn)
        hitBtn.color = .white
        hitBtn.colorBlendFactor = 0.4
        standBtn.position = CGPoint(x:525, y:40)      // x was 600 chg to 525
        standBtn.isHidden = true
    
        button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.view!.frame.width / 3, height: 30)
        button.center = CGPoint(x:205, y:50)
        button.setTitle("music", for: UIControl.State.normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapButton), for: UIControl.Event.touchUpInside)
        
        self.view!.addSubview(button)
        }
    
    
    @objc func didTapButton(){
        if let player = bgplayer, player.isPlaying{
            //stop playback
            button.setTitle("play", for: .normal)
            player.pause()
        }
        else {
            //set up player, and play
            button.setTitle("pause", for: .normal)
            let urlString = Bundle.main.path(forResource: "playlistbj", ofType: "mp3")
            
            do{
                if #available(iOS 10.0, *) {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
                } else {
                    // Fallback on earlier versions
                }
                print("Playback ok")
                try AVAudioSession.sharedInstance().setActive(true)
                print("session is active")
                
                guard let urlString = urlString else{
                    return
                }
               bgplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = bgplayer else{
                    return
                }
                
                player.play()
            }
            catch {
                print ("oops")
            }
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
            
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
            
        
        
        if(touchedNode.name == "dealBtn"){
            deal()
          //  dealArray()
            //deal array here
        }
        
        if(touchedNode.name == "hitBtn"){
            hit()
            //hit array here
        }
        
        if(touchedNode.name == "standBtn"){
            stand()
            //stand array here
        }
       
        
        
     }
    func deal() {
        instructionText.text = ""
        dealBtn.isHidden = true;
        standBtn.isHidden = false
        hitBtn.isHidden = false
        let tempCard = Card(suit: "card_front", value: 0)
        tempCard.position = CGPoint(x:630, y:980)  // x was 630
        addChild(tempCard)
        tempCard.zPosition = 100
        
        let newCard = deck.getTopCard()
        
        var whichPosition = playerCardsY
        var whichHand = player1.hand
        if(self.currentPlayerType is Player){
            whichHand = player1.hand
            whichPosition = playerCardsY;
        } else {
            whichHand = dealer.hand
            whichPosition = dealerCardsY;
        }
        
        whichHand.addCard(card: newCard)
        let xPos = 250 + (whichHand.getLength()*35)     //was 50 cng to 250
        let moveCard = SKAction.move(to: CGPoint(x:xPos, y: whichPosition),duration: 1.0)
        tempCard.run(moveCard, completion: { [unowned self] in
            self.player1.setCanBet(canBet: true)
            if(self.currentPlayerType is Dealer && self.dealer.hand.getLength() == 1){
                self.dealer.setFirstCard(card: newCard)
                self.allCards.append(tempCard)
                tempCard.zPosition = 0
            } else {
                tempCard.removeFromParent()
                self.allCards.append(newCard)
                self.addChild(newCard)
                newCard.position = CGPoint( x: xPos, y: whichPosition)
                newCard.zPosition = 100
            }
            if(self.dealer.hand.getLength() < 2){
                if(self.currentPlayerType is Player){
                    self.currentPlayerType = self.dealer
                }else{
                    self.currentPlayerType = self.player1
                }
                self.deal()
            }else if (self.dealer.hand.getLength() == 2 && self.player1.hand.getLength() == 2) {
                if(self.player1.hand.getValue() == 21 || self.dealer.hand.getValue() == 21){
                    self.doGameOver(hasBlackJack: true)
                } else {
                    self.standBtn.isHidden = false;
                    self.hitBtn.isHidden = false;
                }
            }
            
            if(self.dealer.hand.getLength() >= 3 && self.dealer.hand.getValue() < 17){
                self.deal();
            } else if(self.player1.isYeilding() && self.dealer.hand.getValue() >= 17){
                self.standBtn.isHidden = true
                self.hitBtn.isHidden = true
                self.doGameOver(hasBlackJack: false)
            }
            if(self.player1.hand.getValue() > 21){
                self.standBtn.isHidden = true;
                self.hitBtn.isHidden = true;
                self.doGameOver(hasBlackJack: false);
            }
            
            
            
        })
        
    }
    
    func doGameOver(hasBlackJack: Bool){
        hitBtn.isHidden = true
        standBtn.isHidden = true
        let tempCardX = allCards[1].position.x
        let tempCardY = allCards[1].position.y
        let tempCard = dealer.getFirstCard()
        addChild(tempCard)
        allCards.append(tempCard)
        tempCard.position = CGPoint(x:tempCardX,y:tempCardY)
        tempCard.zPosition = 0
        
        var winner:GenericPlayer = player1
        
        if(hasBlackJack){
            if(player1.hand.getValue() > dealer.hand.getValue()){
               
                
                
                instructionText.text = "You Got BlackJack!";
                moveMoneyContainer(position: playerCardsY)
                //player blackjack array
                playRandomSound(sounds: playerBlackjackSounds)
                                                               //    soundArrayPlayerBlackjack()
                addPlayerScore()
            }
            
            else{
                
                
                
                instructionText.text = "Dealer got BlackJack!";
                moveMoneyContainer(position: dealerCardsY)
                playRandomSound(sounds: dealerBlackjackSounds)
                                                           //      soundArrayDealerBlackjack()
                addDealerScore()
            }
            
            return
            
        }
        
        
        if (player1.hand.getValue() > 21){
            instructionText.text = " Bust!"
            
            winner = dealer
             // playerbust array here
            playRandomSound(sounds: playerBustSounds)
                                                            //       soundArrayPlayerBust()
            addDealerScore()
            }
        
            else if (dealer.hand.getValue() > 21){
                 
            
            instructionText.text = "Dealer Busts. You Win!"
            winner = player1
            
            //dealer bust array
            playRandomSound(sounds: dealerBustSounds)
                                                 //      soundArrayDealerBust()
            addPlayerScore()
            
        }else if (dealer.hand.getValue() > player1.hand.getValue()){
            
            
            instructionText.text = "You Lose!"
            winner = dealer
            //player lose array
            playRandomSound(sounds: playerLoseSounds)
                                                   //     soundArrayPlayerLose()
            addDealerScore()
            
        }
        
        else if (dealer.hand.getValue() == player1.hand.getValue()){
            
            
            instructionText.text = "Tie - Dealer Wins!"
            winner = dealer
            //tie array func
            playRandomSound(sounds: arrayTieSounds)
                                                         //     soundArraytie()
                    
            addDealerScore()
        }
        
        
        else if (dealer.hand.getValue() < player1.hand.getValue()){
            
            
            instructionText.text="You Win!";
            winner = player1
            //dealer lose array
            playRandomSound(sounds: dealerLoseSounds)
                                                  //   soundArrayDealerLose()
                                                                   
            addPlayerScore()
        }
        
        if(winner is Player){
            moveMoneyContainer(position: playerCardsY)
        }else{
            moveMoneyContainer(position: dealerCardsY)
        }
        }
       
    
    
    func moveMoneyContainer(position: Int){
        let moveMoneyContainer = SKAction.moveTo(y: CGFloat(position), duration: 3.0)
        moneyContainer.run(moveMoneyContainer, completion: { [unowned self] in
            self.resetMoneyContainer()
        });
    }
    
    func resetMoneyContainer(){
        //Remove all card from coin container
        moneyContainer.removeAllChildren()
        moneyContainer.position.y = size.height/2
        newGame()
        
    }
    
    func newGame(){
        currentPlayerType = player1
        deck.new()
        instructionText.text = "PRESS DEAL";
                                                     
        dealBtn.isHidden = false
        player1.hand.reset()
        dealer.hand.reset()
        player1.setYielding(yields: false)
        
        for card in allCards{
            card.removeFromParent()
        }
        
        allCards.removeAll()
    }
    
    func hit(){
        if(player1.getCanBet()){
            currentPlayerType = player1
            deal()
            player1.setCanBet(canBet: false)
        }
       // hitArray()
    }
    
    
    func stand(){
        player1.setYielding(yields: true)
        standBtn.isHidden = true
        hitBtn.isHidden = true
        if(dealer.hand.getValue() < 17){
            currentPlayerType = dealer
            deal();
        }else{
            doGameOver(hasBlackJack: false)
        }
       // stickSoundArray()
    }
    
    
    func playRandomSound(sounds: [String]){
         guard let sound = sounds.randomElement(),
             let soundURL = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }

         do {
             audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
         }
         catch {
             print(error)
         }

         audioPlayer?.play()
        
        
        
    
    
    //  calll using          playRandomSound(sounds: dealerBlackJackSounds)
    
    }
    
    
  /*
    
    
    
    func casinoChips(){
     let url = Bundle.main.url(forResource: "chips", withExtension: "mp3")
        //make sure that we have the url, otherwise abort
        guard url != nil else {
            return}
        //create the audio player and play the sound.
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()}
        catch {print("error")}
        }
   

  
   
    
    
    func hitArray(){
        
        let sounds = ["" ]
        guard let sound = sounds.randomElement(),
        let soundURL = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        }
        catch {
        print(error)
    }
   
        let seconds = 2.0
        let when = DispatchTime.now() + seconds
        
        DispatchQueue.main.asyncAfter(deadline: when){
         audioPlayer?.play()
        }}
    
    func dealArray(){

    let sounds = [""]
         
         guard let sound = sounds.randomElement(),
             let soundURL = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }

         do {
             audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
         }
         catch {
             print(error)
         }

         audioPlayer?.play()}
    
     
     
     
     
     
     
     
    */
    
    
}

