//
//  GameViewController.swift
//  Blackjackk
//
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import UIKit
import SpriteKit
 
class GameViewController: UIViewController {
     
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
         
        let scene = GameScene(size:CGSize(width: 768, height: 1024))
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
     
    
    
    
    
    
    
    
    
    
    
}

