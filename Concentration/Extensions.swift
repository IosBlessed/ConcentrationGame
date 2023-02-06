//
//  Extensions.swift
//  Concentration
//
//  Created by Никита Данилович on 04.12.2022.
//
import Foundation
import UIKit

extension UIViewController{
    func alertMessage(dialogMessageTitle: String, dialogMessageText: String, okButtonText: String,buttonHandler:@escaping (UIAlertAction)->Void){
        let dialogMessage = UIAlertController(title: dialogMessageTitle, message: dialogMessageText, preferredStyle: .alert)
       
        let ok = UIAlertAction(title: okButtonText, style: .default, handler:buttonHandler)
       
        dialogMessage.addAction(ok)
        
        present(dialogMessage, animated: true, completion: nil)
  }
   
}
