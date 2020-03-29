//
//  InviteOrJoinViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class InviteOrJoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pushManager = NotificationManager(userID: Firebase.Auth.auth().currentUser?.uid ?? "logged_in_user")
        pushManager.registerForPushNotifications()
    }
    
    
    @IBAction func createPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func joinPressed(_ sender: Any) {
        print(Firebase.Auth.auth().currentUser?.uid)
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
