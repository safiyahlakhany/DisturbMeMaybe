//
//  AnnouncementViewController.swift
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

class AnnouncementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    
    @IBOutlet var tableView: UITableView!
    
    var nameList = [String]()
    var titleList = [String]()
    var descList = [String]()
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell") as! AnnouncementTableViewCell
        cell.announcementHeadLabel.text = titleList[indexPath.row] as! String
        cell.descriptionLabel.text = titleList[indexPath.row] as! String
        cell.announcerLabel.text = nameList[indexPath.row] as! String
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        query()
    }
    
    func query() {
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
                    print(self.queryFamilyTable(fam: fam))
                }
            }
        }
    }
    
    func queryFamilyTable(fam: String) {
        let db = Firestore.firestore()
        db.collection("familyID").whereField("FamilyID", isEqualTo: fam).getDocuments{ (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else
            {
                if querySnapshot!.documents.count != 0 {
                    let document = querySnapshot!.documents[0]
                    if let announcements = document.data()["announcements"] as? [[String: [String]]] // announcement : [announcer: [title, desc]]
                        {
                            for announcement in announcements {
                                // need to query the user database for name
                                for (uid, announcementInfo) in announcement {
                                    print(uid, announcementInfo)
                                    self.queryUserTable(uid: uid, announcementInfo: announcementInfo)
                                }
                            }
                        }
                }
            }
        }
    }
    
    func queryUserTable(uid: String, announcementInfo: [String]) {
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments{ (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else
            {
                let document = querySnapshot!.documents[0]
                if let name = document.data()["name"] as? String
                {
                    self.nameList.append(name)
                    self.titleList.append(announcementInfo[0])
                    self.descList.append(announcementInfo[1])
                    self.tableView.reloadData()
                }
            }
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
