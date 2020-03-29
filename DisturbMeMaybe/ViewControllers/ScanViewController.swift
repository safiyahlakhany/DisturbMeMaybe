//
//  ScanViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var videoView: UIView!
    var familyID = String()
    let db = Firestore.firestore()
    
    enum error: Error {
        case NoCameraAvailable
        case VideoInputInitFail
    }
    
    
    @IBAction func joinButtonPressed(_ sender: Any)
    {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let currentUid = user!.uid
        db.collection("users").document(currentUid).updateData([
            "familyID": familyID,
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do
        {
            try scanQRCode()
        }
        catch
        {
            print("Could not scan QR code ")
        }    }
    

   func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let mechineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if mechineReadableCode.type == AVMetadataObject.ObjectType.qr {
                print(mechineReadableCode.stringValue!)
                canJoinFamily(familyID: mechineReadableCode.stringValue!)
            }
        }
    }
    
    func scanQRCode() throws
    {
        let avCaptureSession = AVCaptureSession()
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("No camera.")
            throw error.NoCameraAvailable
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            print("Failed to init camera.")
            throw error.VideoInputInitFail
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        avCaptureVideoPreviewLayer.frame = videoView.bounds
        self.videoView.layer.addSublayer(avCaptureVideoPreviewLayer)
        avCaptureSession.startRunning()
    }
    
    func canJoinFamily(familyID: String)
    {
        db.collection("familyID").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else
            {
                for document in querySnapshot!.documents
                {
                    if document.documentID == familyID
                    {
                        self.joinButton.isEnabled = true
                        break
                    }
                    
                }
            }
        }
    }

}
