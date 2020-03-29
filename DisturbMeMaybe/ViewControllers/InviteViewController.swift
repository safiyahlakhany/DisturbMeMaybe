//
//  InviteViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth
import Firebase
import FirebaseFirestore

class InviteViewController: UIViewController {

    
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberLabel.text = ""
        self.promptLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func enterPressed(_ sender: Any) {
        
        let num = "+1" + (numberTextField.text!)
        let url = Constants.TwilioStuff.url
        let messageText = "Join your family quarantine together! Download the app here: http://www.appstore.com"
        let parameters = ["From": Constants.TwilioStuff.fromNumber, "To": num, "Body": messageText]
            
  
        Alamofire.request(url, method: .post,  parameters: parameters)
                .authenticate(user: Constants.TwilioStuff.username, password: Constants.TwilioStuff.password)
         .responseJSON { response in
          debugPrint(response)
        }
        self.numberLabel.text = numberTextField.text!
        self.promptLabel.alpha = 0
        self.numberTextField.text = ""
        
    }
    
    
    @IBAction func nextPressed(_ sender: Any) {
        // get familyID
        
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        let currentUid = user!.uid
//
//        let docRef = db.collection("familyID").document(currentUid)
//
//        if let user = user {
//            let name = user.value(forKey: "name")
//        print(name)
//        }
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
