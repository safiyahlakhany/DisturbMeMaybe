//
//  MakeAnnouncementViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit

class MakeAnnouncementViewController: UIViewController {

    
    @IBOutlet weak var announcementTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        // store responses in database
        
        // collapse page
        
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
