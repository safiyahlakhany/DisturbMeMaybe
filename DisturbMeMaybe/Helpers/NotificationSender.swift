//
//  NotificationSender.swift
//  DisturbMeMaybe
//
//  Created by Lenah Syed on 3/28/20.
//  Copyright © 2020 Safiyah Lakhany. All rights reserved.
//

import UIKit
import FirebaseMessaging

// code taken from : https://www.iosapptemplates.com/blog/ios-development/push-notifications-firebase-swift-5


class NotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAdq-Z1Go:APA91bGbB_NQ_lLeIJvweHHXCPmfqP-JqSqPPN1M2QGUhh18xRAXeUO3rbiqFAn7a_l5nZ-QtwxGtn5ooYy1EAcAtJ2uNKd2MWfTQ-wLV0MCOIrsLKo-1zWf_pU6N1Sr8fb-WWN3VYBj", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
