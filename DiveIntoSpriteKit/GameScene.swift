//
//  GameScene.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import SpriteKit

@objcMembers
class GameScene: SKScene, SKPhysicsContactDelegate{
    //making the player rocket
    let player = SKSpriteNode(imageNamed: "player-rocket")
    var touchingPlayer = false
    // optional timer
    var gameTimer: Timer?
    
    //lets music play when game starts
    let music = SKAudioNode(fileNamed: "cyborg-ninja.mp3")
    
    let scoreLabel = SKLabelNode(fontNamed: "Avenir-NextCondensed-Bold")
    
    //Shows text for score at the top of ipad screen
    var score = 0 {
        didSet {
            scoreLabel.text = "SCORE:  \(score)"
        }
        
    }
    
    
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
        
        addChild(music)
        
        // Try to load the Space Dust particle emitter
        if let particles = SKEmitterNode(fileNamed: "Space-Dust") {
            // If the particle emitter file is found, add it to the scene
            particles.advanceSimulationTime(10)
            particles.position.x = 512
            addChild(particles)
            
            gameTimer = Timer.scheduledTimer(timeInterval:0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            
            player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
            player.physicsBody?.categoryBitMask = 1
            
            physicsWorld.contactDelegate = self
            
            
        }
        // Making score label at the top of the screen
        scoreLabel.zPosition = 2
        scoreLabel.position.y = 300
        addChild(scoreLabel)
        
        score = 0
        
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
    
    func createEnemy() {
         createBonus()
        // creating asteroids
        let sprite = SKSpriteNode(imageNamed: "asteroid")
        sprite.position = CGPoint(x: 1200, y: Int.random(in: -350...350))
        sprite.scale(to: CGSize(width: 125, height: 125))
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite .size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        
        //Colliding With Asteroids Part
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.categoryBitMask = 0
        
        func didBegin(_ contact: SKPhysicsContact) {
            guard let nodeA = contact.bodyA.node else {
                return}
            guard let nodeB = contact.bodyB.node else {
                return}
            
            if nodeA == player {
                playerHit(nodeB)
            } else {
                playerHit(nodeA)
            }
        }
        func playerHit(_ node: SKNode) {
            player.removeFromParent()
        }
        
        
    }
    
    func createBonus() {
       
        // creating asteroids
        let sprite = SKSpriteNode(imageNamed: "energy.png")
        sprite.position = CGPoint(x: 1200, y: Int.random(in: -350...350))
        sprite.name = "bonus"
        sprite.zPosition = 1
        addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite .size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        
        //Colliding With Asteroids Part
        sprite.physicsBody?.contactTestBitMask = 1
        sprite.physicsBody?.categoryBitMask = 0
        
        
        
        
        
        sprite.physicsBody?.collisionBitMask = 0
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {
            return
            
        }
        guard let nodeB = contact.bodyB.node else {
            return
            
        }
        
        if nodeA == player {
            playerHit(nodeB)
        } else {
            playerHit(nodeA)
        }
    }
    
    func playerHit(_ node: SKNode) {
        if node.name == "bonus" {
            score += 1
            node.removeFromParent()
            return
        }
        player.removeFromParent()
    }
    
    
    
}

