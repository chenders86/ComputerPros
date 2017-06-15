//
//  HomeViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/8/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Outlets
    @IBOutlet weak var gigabyteLabel: UILabel!
    @IBOutlet weak var progressBar: UIImageView!
    
    // Actions
    @IBAction func hamburgerMenu(_ sender: UIButton) {
    }
    
    @IBAction func appleButton(_ sender: UIButton) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        
        let url = URL(string: "https://www.apple.com".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        let request = URLRequest(url: url!)
        
        controller.webRequest = request
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func windowsButton(_ sender: UIButton) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        
        let url = URL(string: "https://www.microsoft.com".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        let request = URLRequest(url: url!)
        
        controller.webRequest = request
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func bookItButton(_ sender: UIButton) {
    }
    
    @IBAction func facebookButton(_ sender: UIButton) {
    }
    
    @IBAction func twitterButton(_ sender: UIButton) {
    }
}
