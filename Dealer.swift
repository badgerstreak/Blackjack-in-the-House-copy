//
//  Dealer.swift
//  Blackjackk
//
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation

class Dealer: GenericPlayer{
   private var firstCard = Card(suit: "card_front",value: 0)
    
    override init(hand: Hand) {
       super.init(hand: hand)
    }
    
    func setFirstCard(card: Card){
        firstCard = card
    }
    
    func getFirstCard()->Card{
        return firstCard
    }
}
