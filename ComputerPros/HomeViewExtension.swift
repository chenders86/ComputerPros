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
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.WebVC.rawValue) as! WebViewController
        let url = URL(string: "https://www.apple.com".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        controller.webRequest = request
        self.present(controller, animated: true, completion: nil)
    }
    
    func showMicrosoftCom() {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.WebVC.rawValue) as! WebViewController
        let url = URL(string: "https://www.microsoft.com".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        controller.webRequest = request
        self.present(controller, animated: true, completion: nil)
    }
    
    func showSetmore() {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.WebVC.rawValue) as! WebViewController
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
            let controller = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.WebVC.rawValue) as! WebViewController
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
            let controller = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.WebVC.rawValue) as! WebViewController
            let url = URL(string: "https://www.facebook.com/nashvillecomputerpros/".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
            let request = URLRequest(url: url!)
            controller.webRequest = request
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showProCare() {
        
        let procareVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.ProCareVC.rawValue) as! ProCareCloudVC
        
        self.navigationController?.pushViewController(procareVC, animated: true)
    }
    
    func presentViewControllerForName(menuCellName string: MenuCellName) {
        
        switch string {
            
        case .Home:
            self.dismissMenu(self)
            
        case .ProCare:
            UIView.animate(withDuration: 0.2, animations: {
                self.menuLeadingEdge.constant = -228
                self.hiddenDismissButton.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                let proCareCloudVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.ProCareVC.rawValue) as! ProCareCloudVC
                self.navigationController?.pushViewController(proCareCloudVC, animated: true)
            })
            
        case .Inventory:
            UIView.animate(withDuration: 0.2, animations: {
                self.menuLeadingEdge.constant = -228
                self.hiddenDismissButton.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                let inventoryVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.InventoryVC.rawValue) as! InventoryTabBarController
                self.navigationController?.pushViewController(inventoryVC, animated: true)
            })
            
        case .Onsite:
            UIView.animate(withDuration: 0.2, animations: {
                self.menuLeadingEdge.constant = -228
                self.hiddenDismissButton.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                self.showSetmore()
            })
            
        case .Password:
            UIView.animate(withDuration: 0.2, animations: {
                self.menuLeadingEdge.constant = -228
                self.hiddenDismissButton.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                let passwordVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.PassWordVC.rawValue) as! PasswordViewController
                self.navigationController?.pushViewController(passwordVC, animated: true)
            })
            
        case.Contact:
            UIView.animate(withDuration: 0.2, animations: {
                self.menuLeadingEdge.constant = -228
                self.hiddenDismissButton.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                let contactVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.ContactVC.rawValue) as! ContactViewController
                self.navigationController?.pushViewController(contactVC, animated: true)
            })
        }
    }
}
