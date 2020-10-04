//
//  Bank.swift
//  Blackjackk
//
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//
//

import Foundation
import SpriteKit
import AVFoundation



class Bank {
    var balance = 500
    let funds = SKLabelNode(fontNamed: "AvenirNext-Bold")//NEWCODE4
    
    
    init() {
        funds.text = "funds: \(balance)"                      //NEWCODE4
        funds.fontSize = 40                            //NEWCODE4
        funds.fontColor = SKColor.red                  //NEWCODE4
        funds.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left           //NEWCODE4
        funds.position = CGPoint(x: 295, y: 100)                                      //NEWCODE4
        funds.zPosition = 100                                                         //NEWCODE4
    }
        
    
    func resetBalance(){
        
        balance = 500
        
    }
    
    func addMoney(amount: Int){
        balance += amount
        funds.text = "funds: \(balance)"               //NEWCODE4
    }
    
    func subtractMoney(amount: Int){
        balance -= amount
        funds.text = "funds: \(balance)"
        if(balance <= 10){
           // resetBalance()
           // skintSoundArray()
            //possible skint array
        }
    }
    
    func getBalance()->Int{
        return balance
    }
    
    
    
  }
