//
//  MenuVC.swift
//  Loisir
//
//  Created by Faical Sawadogo1212 on 03/03/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
}


class MenuVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // The "game" view controller
    var randomRectVC: GameViewController?
    var gameSceneVC: GameScene?
    
    let rowsPerSection = 3
    let sectionCount   = 1
    
    @IBOutlet weak var scoreTableView: UITableView!
    
    @IBOutlet weak var redSliderBG: UISlider!
    @IBOutlet weak var greenSliderBG: UISlider!
    @IBOutlet weak var blueSliderBG: UISlider!
    
    @IBOutlet weak var redSliderLabelBG: UILabel!
    @IBOutlet weak var greenSliderLabelBG: UILabel!
    @IBOutlet weak var blueSliderLabelBG: UILabel!
    
    @IBOutlet weak var redSliderPaddle: UISlider!
    @IBOutlet weak var greenSliderPaddle: UISlider!
    @IBOutlet weak var blueSliderPaddle: UISlider!
    
    @IBOutlet weak var redSliderLabelPaddle: UILabel!
    @IBOutlet weak var greenSliderLabelPaddle: UILabel!
    @IBOutlet weak var blueSliderLabelPaddle: UILabel!
    
    
    
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
        
    }
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setColorSliderAndLabel()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsPerSection
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        //formatter.string(from: currentDateTime)
        let row  = indexPath.row
        typealias scoreData = (date: String, Score: Int)
        let gameSize = SceneVC?.theScore.length()
        
        if gameSize != nil && row < gameSize! {
            let item = SceneVC?.theScore.getItem(index: row)
            let realScore = Float( (item?.score)!)
            let itemDateTime = item?.date
            let timestamp = formatter.string(from: itemDateTime! as Date)
            
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell.textLabel?.text = String(format: "         Score %d:",
                                          arguments: [row + 1] ) + String(format: " %d  on ",
                                                                          arguments: [Int(realScore)] ) + timestamp
            return cell
            
        }else {
            
            let timestamp = formatter.string(from: currentDateTime as Date)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell.textLabel?.text = String(format: "         Score %d:",
                                          arguments: [row + 1] ) + String(format: " %d  on ",
                                                                          arguments: [0] ) + timestamp
            return cell
       
        
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the control's labels have their correct values
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        scoreTableView.reloadData()
    }
    
    
    
    
    
    func setColorSliderAndLabel() {
        // Set the Color label
        redSliderLabelBG.text = String(format: "%d",
                                     arguments: [Int((randomRectVC?.redSliderVal)! * 255)])
        greenSliderLabelBG.text = String(format: "%d",
                                       arguments: [Int((randomRectVC?.greenSliderVal)! * 255)])
        blueSliderLabelBG.text = String(format: "%d",
                                      arguments: [Int((randomRectVC?.blueSliderVal)! * 255)]) //* 255
        //Set sliders
        redSliderBG.value = Float((randomRectVC?.redSliderVal)!)
        greenSliderBG.value = Float((randomRectVC?.greenSliderVal)!)
        blueSliderBG.value = Float((randomRectVC?.blueSliderVal)!)
        
        // Set the Color label
        redSliderLabelPaddle.text = String(format: "%d",
                                       arguments: [Int((randomRectVC?.redSliderValP)! * 255)])
        greenSliderLabelPaddle.text = String(format: "%d",
                                         arguments: [Int((randomRectVC?.greenSliderValP)! * 255)])
        blueSliderLabelPaddle.text = String(format: "%d",
                                        arguments: [Int((randomRectVC?.blueSliderValP)! * 255)])
        //Set sliders
        redSliderPaddle.value = Float((randomRectVC?.redSliderValP)!)
        greenSliderPaddle.value = Float((randomRectVC?.greenSliderValP)!)
        blueSliderPaddle.value = Float((randomRectVC?.blueSliderValP)!)
    }
    
    func changeBackgroundColor() -> UIColor {
        // Set the label
        let redColor = CGFloat(redSliderBG.value)
        let greenColor = CGFloat(greenSliderBG.value)
        let blueColor = CGFloat(blueSliderBG.value)
        return UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: CGFloat(1))
    }
    
    @IBAction func backgroundColorHandler(_ sender: Any) {
        randomRectVC?.view.backgroundColor = changeBackgroundColor()
        redSliderLabelBG.text = String(format: "%d",
                                       arguments: [Int(redSliderBG.value * 255)])
        greenSliderLabelBG.text = String(format: "%d",
                                       arguments: [Int(greenSliderBG.value * 255)])
        blueSliderLabelBG.text = String(format: "%d",
                                      arguments: [Int(blueSliderBG.value * 255)])
    }
    
    @IBAction func handleGameLevel(_ sender: UIButton) {
        
//        if(sender.titleLabel?.text == "EASY"){
//            SceneVC?.durationPaddle = 1.3
//        }else if(sender.titleLabel?.text == "HARD"){
//            SceneVC?.durationPaddle = 1.0
//        }else {
//             SceneVC?.durationPaddle = 0.8
//        }
        
    }
    @IBAction func paddleColorHandler(_ sender: Any) {
        randomRectVC?.view.backgroundColor = changeBackgroundColor()
        redSliderLabelPaddle.text = String(format: "%d",
                                       arguments: [Int(redSliderPaddle.value * 255)])
        greenSliderLabelPaddle.text = String(format: "%d",
                                         arguments: [Int(greenSliderPaddle.value * 255)])
        blueSliderLabelPaddle.text = String(format: "%d",
                                        arguments: [Int(blueSliderPaddle.value * 255)])
    }
    
    func inverse () -> UIColor {
        // Return opposite color of the background
        let r : CGFloat = CGFloat(redSliderBG!.value)
        let g : CGFloat = CGFloat(greenSliderBG!.value)
        let b : CGFloat = CGFloat(blueSliderBG!.value)
        let a : CGFloat = 1;
        
        return UIColor(red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
    }
    
}
