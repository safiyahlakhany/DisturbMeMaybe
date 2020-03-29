//
//  MakeAnnouncementViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseMessaging
import FirebaseDatabase
import FirebaseFirestore

class MakeAnnouncementViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var announcementTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descriptionTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        let user = Auth.auth().currentUser
        var userFamilyID: String?
        
        
        if let user = user {
          let currentEmail = user.email
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
                                                sender.sendPushNotification(to: fcmToken, title: self.announcementTextField.text!, body: self.descriptionTextField.text!)
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
    
            
            
           
        // store responses in database
        let db = Firestore.firestore()
        var currentAnnouncements = [[String: [String]]]()
        
        // get the current announcements
        db.collection("familyID").whereField("FamilyID", isEqualTo: userFamilyID).getDocuments{ (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if querySnapshot!.documents.count != 0 {
                    // if we have announcements already populated...
                    if let announcements = querySnapshot!.documents[0].data() as? [[String: [String]]] {
                        currentAnnouncements = announcements
                    }
                }
            }
        }
        
        // if there was not already announcements inside
        if currentAnnouncements.count != 0 {
            currentAnnouncements = [[user?.uid ?? "" : [announcementTextField.text!, descriptionTextField.text!]]]
        } else {
            currentAnnouncements.append([user?.uid ?? "" : [announcementTextField.text!, descriptionTextField.text!]])
        }
        
        // update the database
        db.collection("familyID").document(userFamilyID ?? "").updateData([
                               "announcements": currentAnnouncements
                               ]) { (error) in
                                   
                               if error != nil {
                                   // Show error message
                                   print("error saving data")
                                }
        }
        
        
        
        // collapse page
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
