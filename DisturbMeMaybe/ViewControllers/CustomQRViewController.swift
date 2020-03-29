//
//  CustomQRViewController.swift
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

class CustomQRViewController: UIViewController {
    
    
    @IBOutlet weak var QRImageView: UIImageView!
    var familyID = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!

        db.collection("users").whereField("uid", isEqualTo: userID).getDocuments{ (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else
            {
                let document = querySnapshot!.documents[0]
                if let fam = document.data()["familyID"] as? String
                {
                    self.familyID = fam
                }
                self.displayCode()
            }
        }
    }
    
    func displayCode()
    {
        if familyID != ""
        {
            let data = familyID.data(using: .ascii, allowLossyConversion: false)
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")
            qrFilter?.setValue(data, forKey: "inputMessage")
            
            let ciImage = qrFilter?.outputImage
            
            let scaleX = QRImageView.frame.size.width / (ciImage?.extent.size.width)!
            let scaleY = QRImageView.frame.size.height / (ciImage?.extent.size.height)!
             
            let transformedImage = ciImage!.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
             
            QRImageView.image = UIImage(ciImage: transformedImage)
        }
    }
}
