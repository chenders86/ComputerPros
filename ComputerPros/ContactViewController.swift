//
//  ContactViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/27/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var mainLogoImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Contact"
        setupLogo()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func phoneButtonPressed(_ sender: UIButton) {
        
        if let url = URL(string: "telprompt://6153838200") {
            if #available(iOS 10, *) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    @IBAction func mailButtonPressed(_ sender: UIButton) {
        
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        
        if MFMailComposeViewController.canSendMail() {
            mailVC.setToRecipients(["info@nashvillecomputerpros.com"])
            self.present(mailVC, animated: true, completion: nil)
        } else {
            return
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail was canceled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupLogo() {
        
        mainLogoImageView.image = UIImage(named: "cpros-logo-large")?.withRenderingMode(.alwaysTemplate)
        
        mainLogoImageView.tintColor = UIColor(hue: 0.5361111111, saturation: 1.00, brightness: 0.85, alpha: 1.0)
        
        mainLogoImageView.contentMode = .scaleAspectFit
    }
}
