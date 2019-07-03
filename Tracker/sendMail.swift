//
//  sendMail.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/3/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

//MARK: - Send Email
//@IBAction func actionSendEmail(_ sender: Any) {
//
//    if !MFMailComposeViewController.canSendMail() {
//        print("Mail services are not available")
//        return
//    }
//    let image = UIImage(named:"testImage") // Your Image
//    let imageData = UIImagePNGRepresentation(image!) ?? nil
//    let base64String = imageData?.base64EncodedString() ?? "" // Your String Image
//    let strHtml = "<html><body><p>Header: Hello Test Email</p><p><b><img src='data:image/png;base64,\(String(describing: base64String) )'></b></p></body></html>"
//    let composeVC = MFMailComposeViewController()
//    composeVC.mailComposeDelegate = self
//    // Configure the fields of the interface.
//    composeVC.setToRecipients(["address@example.com"])
//    composeVC.setSubject("Hello!")
//    composeVC.setMessageBody(strHtml, isHTML: true)
//
//    // Present the view controller modally.
//    self.present(composeVC, animated: true, completion: nil)
//}
//
// //MARK:- MFMailCompose Delegate Methods
//func mailComposeController(_ controller: MFMailComposeViewController,
//                           didFinishWith result: MFMailComposeResult, error: Error?) {
//    // Dismiss the mail compose view controller.
//    controller.dismiss(animated: true, completion: nil)
//}
