//
//  ViewControllerFinalResult.swift
//  Concentration
//
//  Created by Никита Данилович on 16.11.2022.
//

import UIKit

class ViewControllerFinalResult: UIViewController {
    
    var score = "0"
    var level = "Easy"
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    
    
    @IBOutlet var endGameButtons: [RoundButton]!

    
    @IBAction func pressedEndGameButton(_ sender: RoundButton) {
        print(sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vcBackToMenu = segue.destination as? ViewController
        vcBackToMenu?.slideFromAnotherScreen = true
    }
    @IBOutlet weak var finalLevel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.finalScore.text = self.score
        self.finalLevel.text = self.level
    }
    
}
