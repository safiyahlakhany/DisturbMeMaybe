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
        if let user = user {
          let currentUid = user.uid
          let currentEmail = user.email
          
            // find all users that have the same user id as the current user
            // use albert for now
            /*let usersRef = Database.database().reference(withPath: "users")
            usersRef.queryOrdered(byChild: "uid")
                    .queryEqual(toValue: "aaa@aaa.com")
                    .observe(.value, with: { snapshot in

                // if you know that your value will not be nil, then you can unwrap like below
                //let foo = snapshot.value as! [String: AnyObject]

                if let foo = snapshot.value as? [String: AnyObject] {
                    let name = foo["name"] as? String
                    let email = foo["email"] as? String
                }

            }*/

            
        
        }
        
        // store responses in database
        
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
