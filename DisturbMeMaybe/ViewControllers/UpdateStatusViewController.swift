//
//  UpdateStatusViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class UpdateStatusViewController: UIViewController {

    
    // 1 = green, 2 =  orange, 3 = red
    var availability = 0
    
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var statusTextField: UITextField!
    
    @IBOutlet weak var notifySwitch: UISwitch!
    
    
    @IBOutlet weak var greenButton: UIButton!
    
    
    @IBOutlet weak var orangeButton: UIButton!
    
    
    @IBOutlet weak var redButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenButton.alpha = 0.25
        orangeButton.alpha = 0.25
        redButton.alpha = 0.25

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        greenButton.alpha = 1
        orangeButton.alpha = 0.25
        redButton.alpha = 0.25
        availability = 1
        
    }
    
    
    @IBAction func orangeButtonPressed(_ sender: Any) {
        orangeButton.alpha = 1
        greenButton.alpha = 0.25
        redButton.alpha = 0.25
        
        availability = 2
    }
    
    @IBAction func redButtonPressed(_ sender: Any) {
        redButton.alpha = 1
        greenButton.alpha = 0.25
        orangeButton.alpha = 0.25
        availability = 3
        
    }
    
    
    @IBAction func updateButtonPressed(_ sender: Any)
    {
        // Check that status != empty
        // Check that availability != 0
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let currentUid = user!.uid
        db.collection("users").document(currentUid).updateData([
            "status": statusTextField.text,
            "availability" : self.availability
            
            ])
         
        if notifySwitch.isOn {
            var userFamilyID: String = ""
            if let user = user {
                    let usersRef = Database.database().reference(withPath: "users")
                    // find all users that have the same user id as the current user
                    // use albert for now
                    
                    let db = Firestore.firestore()
                    let userID : String = (Auth.auth().currentUser?.uid)!
                    db.collection("users").whereField("uid", isEqualTo: userID).getDocuments{ (querySnapshot, error) in
                      if let error = error {
                        print("Error getting documents: \(error)")
                      }
                      else
                      {
                        let document = querySnapshot!.documents[0]
                          if let familyID = document.data()["familyID"] as? String
                          {
                            let name = document.data()["name"] as! String
                            userFamilyID = familyID
                            // continue with querying familyID for family members
                            db.collection("familyID").whereField("FamilyID", isEqualTo: familyID).getDocuments{ (querySnapshot, error) in
                                if let error = error {
                                    print("Error getting documents: \(error)")
                                }
                                else {
                                    let document = querySnapshot!.documents[0]
                                    if let familyMembers = document.data()["FamilyMembers"] as? [String] {
                                        for member in familyMembers {
                                            
                                            
                                            // continue with querying users_table for family members
                                            db.collection("users_table").whereField("uid", isEqualTo: member).getDocuments{ (querySnapshot, error) in
                                                if querySnapshot?.documents.count != 0 {
                                                    let document = querySnapshot!.documents[0]
                                                    if let fcmToken = document.data()["fcmToken"] as? String {
                                                        let sender = NotificationSender()
                                                        sender.sendPushNotification(to: fcmToken, title: "\(name) just updated their status!", body: self.statusTextField.text!)
                                                        
                                                
                                            }
                                        }
                                    }
                                    
                                }
                            }
                          }
                      }
                    }
                }
                }
        }
        
        // add to data base
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
