//
//  GameScene.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import SpriteKit

@objcMembers
class GameScene: SKScene {
    //making the player rocket
    let player = SKSpriteNode(imageNamed: "player rocket")
    var touchingPlayer = false
    override func didMove(to view: SKView) {
        player.position.x = -400
        // making the rocket show infront of the space dust
        player.zPosition = 1
        addChild(player)
        
        // this method is called when your gamescene is ready to run
        
        // Make the background show up
        let background = SKSpriteNode(imageNamed: "space.jpg")
        background.zPosition = -1
        addChild(background)
        
        // Try to load the Space Dust particle emitter
        if let particles = SKEmitterNode(fileNamed: "Space-Dust") {
            // If the particle emitter file is found, add it to the scene
            particles.advanceSimulationTime(10)
            particles.position.x = 512
            addChild(particles)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // this method is called when the user touches the screen
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        if tappedNodes.contains(player) {
            touchingPlayer = true
        }
        
    }
    // making the player able to move the rocket 
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchingPlayer else { return }
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        player.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user stops touching the screen
        touchingPlayer = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // this method is called before each frame is rendered
    }
}

