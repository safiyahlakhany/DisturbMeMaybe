//
//  AnnouncementViewController.swift
//  DisturbMeMaybe
//
//  Created by Safiyah Lakhany on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit

class AnnouncementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    
    @IBOutlet var tableView: UITableView!
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell")!
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
