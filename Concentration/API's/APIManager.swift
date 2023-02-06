//
//  APIManager.swift
//  Concentration
//
//  Created by Никита Данилович on 25.11.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    static let shared = APIManager()
    
    private func configureFB() -> Firestore{
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
  
    func getAllDocuments(collection:String, completion: @escaping (QuerySnapshot?)->Void){
            let db = configureFB()
        db.collection(collection).getDocuments() {
            (QuerySnapshot, error) in
            guard error == nil else{return}
            completion(QuerySnapshot!)
        }
    }
    func addNewUser(collection:String, docName:String,login:String, email: String,password:String, id:Int){
        let db = configureFB()
        db.collection(collection).document(docName).setData([
            "ID":id,
            "login":login,
            "E-mail":email,
            "password":password
        ]){
            (error) in
            guard error == nil else{print(error!);return}
            print("User created Successfully!")
        }
}
    func addNewUserStatistics(collection:String, docName:String,id:Int,login:String,games:Int,totalScore:Int){
        let db = configureFB()
        db.collection(collection).document(docName).setData([
            "ID":id,
            "login":login,
            "games":games,
            "totalScore":totalScore
        ]){
            (error) in
            guard error == nil else{print(error!);return}
            print("Statistics for user was created successfully as well!")
        }
    }
}
