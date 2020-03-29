//
//  AuthenticationViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class AuthenticationViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        SetUpElements()
    }
    
    func SetUpElements(){
        
        // hide error label
        errorLabel.alpha = 0
    }

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        // Validate Fields
        let error = validateFields()
        
        if error != nil
        {
            // there was an error with fields, disp error message
            showError(error!)
        }
        else
        {
            let name = nameTextField.text!.trimmingCharacters(in: .newlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else{
                    
                    // User was created successfully
                    let db = Firestore.firestore()
                    

                    
                    

                    db.collection("users").document(result!.user.uid).setData([
                        "name":name,
                        "uid": result!.user.uid,
                        "availability" : 1,
                        "status" : "",
                        "familyID" : ""
                        ]) { (error) in
                            
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data.")
                        }
                }
                    // Transition to the home screen
                    self.transitionToInvOrJoin()
                }
            }
            
        }
        
    }
    
    
    @IBAction func SignInTapped(_ sender: Any) {
        
        // Validate Text Fields
        let error = validateFields()
        
        if error != nil
        {
            // there was an error with fields, disp error message
            showError(error!)
        }
        else
        {
            // check if name is right?
            let name = nameTextField.text!.trimmingCharacters(in: .newlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError(error!.localizedDescription)
                }
                else{
                    self.transitionToMain()
                }
            }
            
        }
    }
    
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    
    func validateFields() -> String? {
        
        if (nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return "Please fill in all fields."
        }
        
        // password strength
        
        return nil
    }
    
    func showError(_ Message:String)
    {
        errorLabel.text = Message
        errorLabel.alpha = 1
    }
    
    func transitionToMain()
    {
        let mainViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController) as? MainViewController
        view.window?.rootViewController = mainViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToInvOrJoin()
    {
        self.performSegue(withIdentifier: "AfterSignUp", sender: self)
    }

}
