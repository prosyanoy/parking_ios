//
//  FeedbackViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//

import UIKit
import MessageUI

final class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = .white
        title = "Обратная связь"
        
        if !MFMailComposeViewController.canSendMail() {
                    print("Mail services are not available")
                    return
                }
        sendFeedBack()
    }
    
    func sendFeedBack() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["support@pros.sbs"])
        composeVC.setSubject("Subject")
        composeVC.setMessageBody("Message Body", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
