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




