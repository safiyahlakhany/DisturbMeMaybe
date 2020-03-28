//
//  UpdateStatusViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit

class UpdateStatusViewController: UIViewController {

    var availability = 0
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
