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
    override func didMove(to view: SKView) {
        
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
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user stops touching the screen
    }

    override func update(_ currentTime: TimeInterval) {
        // this method is called before each frame is rendered
    }
}

