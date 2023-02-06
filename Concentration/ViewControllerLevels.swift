//
//  ViewController.swift
//  Concentration
//
//  Created by Никита Данилович on 22.07.2022.
//

import UIKit

class ViewControllerLevels: UIViewController {
    @IBAction func gameViewController(_ sender: UIButton) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        if let gmvc = storyboard.instantiateViewController(identifier: "GMVC") as? ViewControllerGame{
            gmvc.mode = sender.titleLabel?.text! ?? "default"
            
            show(gmvc,sender:nil)
        }
    }
    
}
