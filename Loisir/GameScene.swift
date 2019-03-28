//
//  GameScene.swift
//  Loisir
//
//  Created by Faical Sawadogo1212 on 03/01/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    var randomRectVC: GameViewController?
    
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    
    var score = [Int]()
    var theScore = Game()
    var thisScore : Int = 0
    var gameTimer: Timer?
    var gameOverFlag = false
    var gameresumeFlag = false
    var gameStart = Bool()
    var gameDuration: TimeInterval = 15.0
    var durationPaddle: Double = 0.0
    
    var timeRemaining = 0 {
        didSet { topLbl.text = "Timer: \(timeRemaining) - Your Score: \(score[0]) - Auto Player Score: \(score[1]) " }
    }
    
    private var gameLabelMessage: String {
        return "Timer: \(timeRemaining) - Your Score: \(score[1]) - Auto Player Score: \(score[0]) "
    }
    
    override func didMove(to view: SKView) {
        
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
       
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "Timer: \(timeRemaining) - Your Score: \(score[0]) - Auto Player Score: \(score[1]) "
        
        let randImpulse  = Int.random(in: 10 ... 50)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: randImpulse  , dy: randImpulse ))
        timeRemaining = Int(gameDuration)
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1,
                                         repeats: true)
        { _ in self.decrementCounter() }

         randomRectVC?.resumeGameRunning()
        
    }
    
    // function that decrease time until 0
    func decrementCounter( ) {
        timeRemaining = timeRemaining - 1
        if timeRemaining == 0 {
            gameOverFlag = true
        }

    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if gameOverFlag {
            if (score[0]) == 0 {
                thisScore = 0
            }else {
                thisScore = abs((score[0] - score[1]))
            }
            
            theScore.addItem(scoreValue: thisScore)
            timeRemaining = Int(gameDuration)
            topLbl.text = "GAME OVER"
            self.physicsWorld.speed = 0.0
            randomRectVC?.gameOver()
        }
            
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        }
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
}
