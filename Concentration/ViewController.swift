//
//  ViewControllerMenu.swift
//  Concentration
//
//  Created by Никита Данилович on 18.11.2022.
//

import UIKit

class ViewController: UIViewController {

    var isUserActive:Bool = false
    
    @IBOutlet weak var userDetails: UIButton!
    var slideFromAnotherScreen = false
    
    @IBOutlet weak var signInButton: RoundButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!isUserActive){
            self.userDetails.isHidden = true
        }else{
            self.userDetails.isHidden = false
            self.signInButton.isHidden = true
        }
        if self.slideFromAnotherScreen == true{
            self.navigationItem.hidesBackButton = true
            self.slideFromAnotherScreen = false
        }
    }
    
    @IBAction func showUser(_ sender: Any) {
        
    }


}
