//
//  GameViewController.swift
//  Loisir
//
//  Created by Faical Sawadogo1212 on 03/01/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


var currentGameType = gameType.medium
var SceneVC: GameScene?
var configVC: MenuVC?

class GameViewController: UIViewController {
    
    
    
    @IBOutlet weak var playBarBtn: UIBarButtonItem!
    @IBOutlet weak var pauseBarBtn: UIBarButtonItem!
    private var rowCount       = 0
    private let sectionCount   = 1
    private var gameInProgress = false
    private var gameRunning    = false
    
    var tableEditingStyle : UITableViewCell.EditingStyle = .none
    
  
    
    var redSliderVal : CGFloat = 0.5
    var greenSliderVal : CGFloat = 0.5
    var blueSliderVal : CGFloat = 0.5
    
    var redSliderValP : CGFloat = 0.5
    var greenSliderValP : CGFloat = 0.5
    var blueSliderValP : CGFloat = 0.5
    var gameLabel = SceneVC?.topLbl
    var score = SceneVC?.score
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.backgroundColor = configVC?.changeBackgroundColor() ?? .gray
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }

    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
   @IBAction func startGamebtnHandle(_ sender: UIBarButtonItem) {
    if !gameInProgress {
        //startNewGame()
        return
    }

    // We have a game in progress, pause or resume?
    if gameRunning {
        pauseGameRunning()
        gameRunning = false

    } else {
        resumeGameRunning()
        gameRunning = true
    }
   }

    @IBAction func handlePause(_ sender: UIBarButtonItem) {
        if (SceneVC?.gameresumeFlag)! {
            sender.title = "Pause"
           // pauseGameRunning()
        } else {
            sender.title = "Resume"
            //resumeGameRunning()
        }

    }
    

    // MARK: - ==== Timer Stuff ====
    private func startNewGame()
    {
        // Init
        gameInProgress = true
        gameRunning    = true

        // Start the action
        resumeGameRunning()

    }
    
    func resumeGameRunning()
    {
        
//         //SceneVC?.startGame()
//        
//        // Timer to control the game
//        SceneVC?.gameTimer = Timer.scheduledTimer(withTimeInterval: 1,
//                                         repeats: true)
//        { _ in SceneVC?.decrementCounter() }
        
        
        // Debug
        print("Resume")
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if !gameInProgress {
            startNewGame()
            return
        }
        
        // We have a game in progress, pause or resume?
        if gameRunning {
            pauseGameRunning()
            gameRunning = false
            
        } else {
            resumeGameRunning()
            gameRunning = true
        }
    }

    func gameOver() {
        // Stop the action
        pauseGameRunning()

        // No longer in progress or running
        gameInProgress = false
        gameRunning    = false
    }

    private func pauseGameRunning() {
        // Stop the game timer
        if let timer = SceneVC?.gameTimer { timer.invalidate() }

        // Remove the reference to the timer object
        SceneVC?.gameTimer = nil

        // Debug
        print("Paused")
    }


    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Game will not be running if either gameInProgress or gameRunning is false
        if gameInProgress && gameRunning {
            // A game is in progress and is running so pause it
            pauseGameRunning()
        }


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Game will not be running if either gameInProgress or gameRunning is false
        if gameInProgress && gameRunning {
            // The game was paused in viewWillDisappear, resume it
            
            resumeGameRunning()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
