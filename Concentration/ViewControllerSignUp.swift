//
//  ViewControllerSignIn.swift
//  Concentration
//
//  Created by Никита Данилович on 25.11.2022.
//

import Foundation
import UIKit

class ViewControllerSignUp: UIViewController {

 
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet var requiredFields: [UILabel]!
    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for i in 0..<requiredFields.count{
            requiredFields[i].isHidden = true
        }
    }
 

    private func showRequired(textField:UITextField, index: Int){
        
        guard textField.text == "" else{
            requiredFields[index].isHidden = true
            return
        }
        requiredFields[index].isHidden = false
        
    }
    private func checkIfRequiredFields()->Bool{
        var fieldsAreCorrect = true
        for i in 0..<self.requiredFields.count{
            guard self.requiredFields[i].isHidden == true else{
                fieldsAreCorrect = false;
                self.alertMessage(dialogMessageTitle: "Wrong data", dialogMessageText:"Please, fill in required fields", okButtonText: "OK",buttonHandler:{_ in});
                return fieldsAreCorrect
            }
        }
        return fieldsAreCorrect
    }
    private func accountCreation(){
            APIManager.shared.addNewUser(collection: "userAccounts", docName: "user\(self.id+1)", login: self.loginField.text!,email:self.emailField.text!, password: self.passwordField.text!, id: self.id+1)
            APIManager.shared.addNewUserStatistics(collection: "userStatistics", docName: "user\(self.id+1)", id: self.id+1, login: self.loginField.text!, games: 0, totalScore: 0)
          
        self.alertMessage(dialogMessageTitle: "Success", dialogMessageText: "Your account was created now", okButtonText: "OK",buttonHandler:{
            _ in
            let storyboard = UIStoryboard(name:"Main", bundle:nil)
            if let mainMenu = storyboard.instantiateViewController(withIdentifier: "MainMenu") as? ViewController{
                mainMenu.isUserActive = true
                mainMenu.slideFromAnotherScreen = true
                self.show(mainMenu, sender:nil)
            }
        })

    }
    
    
    
    private var id:Int = 0
    @IBAction func signIn(_ sender: UIButton) {
       
        for i in 0..<self.textFields.count{
            
            self.showRequired(textField: self.textFields[i], index: i)
        }
        if(self.checkIfRequiredFields()){
            APIManager.shared.getAllDocuments(collection: "userAccounts", completion: {
                QuerySnapshot in
                var checkIfLoginAvailable:Bool = true
                for document in QuerySnapshot!.documents{
                    guard document.data()["login"] as! String != self.loginField.text! else{
                        checkIfLoginAvailable = false
                        self.alertMessage(dialogMessageTitle: "Login unavailable", dialogMessageText: "Current login already exists", okButtonText: "OK",buttonHandler:{_ in})
                        return
                    }
                    self.id = document.data()["ID"] as! Int
                }
                    if(checkIfLoginAvailable){
                        self.accountCreation()
                }
            })
        }
    }
   

}
