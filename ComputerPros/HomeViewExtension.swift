//
//  HomeViewExtension.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/25/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func showAppleCom() {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        let url = URL(string: "https://www.apple.com".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        controller.webRequest = request
        self.present(controller, animated: true, completion: nil)
    }
    
    func showMicrosoftCom() {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        let url = URL(string: "https://www.microsoft.com".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        controller.webRequest = request
        self.present(controller, animated: true, completion: nil)
    }
    
    func showSetmore() {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        let url = URL(string: "https://my.setmore.com/bookingpage/6e67a3dd-6628-421a-93c0-766663d17287".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        controller.webRequest = request
        self.present(controller, animated: true, completion: nil)
    }
    
    func showTwitter() {
        
        let twURL = URL(string: "https://twitter.com/nashvillecpros?lang=en")!
        
        if UIApplication.shared.canOpenURL(twURL) {
            UIApplication.shared.open(twURL, options: [:], completionHandler: nil)
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
            let url = URL(string: "https://twitter.com/nashvillecpros?lang=en".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
            let request = URLRequest(url: url!)
            controller.webRequest = request
            self.present(controller, animated: true, completion: nil)
        }

    }
    
    func showFacebook() {
        
        let fbURL = URL(string: "https://www.facebook.com/nashvillecomputerpros/")!
        
        if UIApplication.shared.canOpenURL(fbURL) {
            UIApplication.shared.open(fbURL, options: [:], completionHandler: nil)
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
            let url = URL(string: "https://www.facebook.com/nashvillecomputerpros/".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
            let request = URLRequest(url: url!)
            controller.webRequest = request
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    func presentViewControllerForName(menuCellName string: MenuCellName) {
        
        switch string {
            
        case .Home:
            print("Home")
        case .ProCare:
            print("ProCare")
        case .Inventory:
            print("Inventory")
        case .Onsite:
            print("On-Site")
        case .Password:
            print("Password")
        case.Contact:
            print("Contact Us")
            
        }
    }
}
