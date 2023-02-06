//
//  ViewControllerGame.swift
//  Concentration
//
//  Created by Никита Данилович on 22.07.2022.
//

import UIKit
import SwiftUI

class ViewControllerGame: UIViewController {
    
    let game = Game()
    
    var mode = ""
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var gameMode: UILabel!
    
    @IBOutlet var animals: [UIButton]!
    
    @IBAction func buttonFlip(_ sender: UIButton){
        game.flipButton(button: sender)
        perform(#selector(checkEndGame),with:nil,afterDelay: 0.5)
    }
    @objc func checkEndGame(){
        if game.gameSquares() == 0{
            performSegue(withIdentifier: "check", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewControllerFinalResult
        vc.score = String(game.points)
        vc.level = game.mode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        game.startGame(gameMode:gameMode,mode:mode,animals:animals,score:score)
        
    }
}


class Game : UIViewController{
    
    var emodjis:[String] = []
    
    var mode = ""

    var gameMode:UILabel!
    
    var animals:[UIButton] = []
    
    var flippedAnimals:[UIButton] = []
    
    var points = 0
    
    var score:UILabel!
    
    var checkIfEnd:Int = 0
    
    var emodjisOnLevel:Int = 0
    
    func startGame(gameMode:UILabel,mode:String,animals:[UIButton],score:UILabel){
        
        self.gameMode = gameMode
        self.mode = mode
        self.animals = animals
        self.score = score
        if self.score.text?.isEmpty != nil {
            self.score.text = "0"
        }
        self.gameMode.text = mode
        gameField(squaresOnScreen:countOfSquares())
        
        clearButtonsBackgroundColor()
        
        var timeForAttention:Double = 0.0
        
        for animal in animals{
            if animal.isHidden != true{
                timeForAttention += 0.5
            }
        }
        
        UIView.animate(withDuration: timeForAttention, animations:hideEmodjis){ finished in
            if finished{
                for animal in self.animals{
                    animal.setTitle("", for: .normal)
                }
            }
        }
        
    }
    
    func hideEmodjis(){
        for animal in animals{
            if animal.isHidden != true{
                animal.setTitle(emodjis[animal.tag], for: .normal)
                animal.titleLabel?.alpha = 0.0
                animal.backgroundColor = .systemBlue
            }
        }
    }
    
    func clearButtonsBackgroundColor(){
        
        for animal in animals{
            if animal.isHidden != true {
                animal.backgroundColor = .clear
                animal.setTitle(emodjis[animal.tag], for: .normal)
            }
        }
        
    }
    
    func gameField(squaresOnScreen:Int){
        for i in squaresOnScreen..<animals.count{
             animals[i].isHidden = true
         }
    }
    func countOfSquares() -> Int{
        var squares = 0
        switch(mode){
            case "Easy":
                squares = 4
            emodjis = ["🙉","🙉","🐹","🐹"]
                break;
            case "Medium":
                squares = 8
            emodjis = ["🙉","🙉","🐹","🐹","🐼","🐼","🦁","🦁"]
                break;
            case "Hard":
                squares = 12
            emodjis = ["🙉","🙉","🐹","🐹","🐼","🐼","🦁","🦁","🐥","🐥","🐸","🐸"]
                break;
            default:
                squares = 4
        }
        emodjis.shuffle()
        return squares
    }
    func checkFlipped(button:UIButton){
        flippedAnimals.append(button)
        if flippedAnimals.count == 2{
            if flippedAnimals[0].currentTitle! == flippedAnimals[1].currentTitle!{
                perform(#selector(equalAnimals), with: nil, afterDelay: 0.5)
            }else{
                perform(#selector(differentAnimals), with: nil, afterDelay: 0.5)
            }
        }
    }
    @objc func differentAnimals(){
        for i in 0..<flippedAnimals.count{
            flippedAnimals[i].setTitle("", for: .normal)
            flippedAnimals[i].backgroundColor = #colorLiteral(red: 0.006242598873, green: 0.4581466317, blue: 0.8921137452, alpha: 1)
        }
        minusPoints()
        flippedAnimals.removeAll()
    }
    
    @objc func equalAnimals(){
        for i in 0..<flippedAnimals.count{
            flippedAnimals[i].isHidden = true
        }
        plusPoints()
        flippedAnimals.removeAll()
    }
    func flipButton(button:UIButton){
        let emodji:String = emodjis[button.tag]
        if button.currentTitle == nil || button.currentTitle == ""{
            button.setTitle(emodji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            checkFlipped(button:button)
        }
    }
    func checkScore(){
        self.score.text = String(points)
    }
    func minusPoints(){
        if points != 0{
            points = points - 1
            checkScore()
        }
    }
    func plusPoints(){
        points = points + 1
        checkScore()
    }
    func gameSquares() -> Int{
        var data = 0
        for i in 0..<animals.count{
            if animals[i].isHidden != true{
                data+=1
            }
        }
        return data
    }
}


