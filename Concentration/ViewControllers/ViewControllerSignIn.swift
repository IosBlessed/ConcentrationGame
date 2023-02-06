//
//  ViewControllerSignIn.swift
//  Concentration
//
//  Created by Никита Данилович on 04.12.2022.
//

import UIKit


class ViewControllerSignIn: UIViewController{

    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet var requiredFields: [UILabel]!
    
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for fields in self.requiredFields{
            fields.isHidden = true
        }
    }

    func checkIfFieldsNotEmpty(textField:UITextField, index: Int){
        guard textField.text == "" else{
            requiredFields[index].isHidden = true
            return
        }
        requiredFields[index].isHidden = false
        self.alertMessage(dialogMessageTitle: "Wrong data", dialogMessageText:"Please, fill in required fields", okButtonText: "OK",buttonHandler:{_ in})
        
        
    }
    func checkIfAccountExists(){
        APIManager.shared.getAllDocuments(collection: "userAccounts", completion:{
            QuerySnapshot in
            for document in QuerySnapshot!.documents{
                if(document.data()["login"] as! String == self.loginField.text!){
                    if(document.data()["password"] as! String == self.passwordField.text!){
                        let storyboard = UIStoryboard(name:"Main", bundle: nil)
                        if let mainMenu = storyboard.instantiateViewController(identifier: "MainMenu") as? ViewController{
                            mainMenu.isUserActive = true
                            mainMenu.slideFromAnotherScreen = true
                            self.show(mainMenu, sender: nil)
                        }
                        return
                        
                    }else{
                        self.alertMessage(dialogMessageTitle: "Incorrect password!", dialogMessageText: "Please, try once again", okButtonText: "OK",buttonHandler:{_ in})
                        self.loginField.text = ""
                        self.passwordField.text = ""
                        return
                    }
                }
                
            }
            self.alertMessage(dialogMessageTitle: "Ooops!", dialogMessageText: "Your user doesn't exist", okButtonText: "OK",buttonHandler:{_ in})
            self.loginField.text = ""
            self.passwordField.text = ""
        }
        )
    }

  
    @IBAction func loginButton(_ sender: UIButton) {
        for index in 0..<self.textFields.count{
            self.checkIfFieldsNotEmpty(textField: self.textFields[index], index: index)
        }
        
        var showedRequiredFields:Int = 0
        for requiredField in self.requiredFields{
            guard requiredField.isHidden == true else{return}
            showedRequiredFields += 1
        }
        if(showedRequiredFields == self.requiredFields.count){
            self.checkIfAccountExists()

        }
     
    }
  

}
