//
//  tableType.swift
//  Blackjack in the House
//
//  Created by Joe Curran on 07/10/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation
import UIKit


 
enum TableType: String {
    case ovaloffice = "ovaloffice"
    case austin = "austin"
    case bond = "bond"
    case moesbar = "moes bar"
    case deadpool = "deadpool"
}
extension TableType {
    static func `for`(playerScore: Int) -> TableType {
        switch playerScore {
        case 0...5:
            return .bond
        case 6...10:
            return .ovaloffice
        case 11...15:
            return .austin
        case 16...20:
            return .deadpool
        default:
            return .moesbar
        }
    }
    var imageName: String {rawValue}
  }




