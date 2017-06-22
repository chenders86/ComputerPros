//
//  HomeViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/8/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        menuView.layer.shadowOffset = CGSize(width: 0, height: 9)
    }
    
    // Outlets
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var gigabyteLabel: UILabel!
    @IBOutlet weak var progressBar: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuLeadingEdge: NSLayoutConstraint!
    @IBOutlet weak var hiddenDismissButton: UIButton!
    
    
    
    // Actions
    @IBAction func hamburgerMenu(_ sender: UIButton) {
        
        menuLeadingEdge.constant = 0
        
        UIView.animate(withDuration: 0.2, animations: {
            self.hiddenDismissButton.alpha = 0.25
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func dismissMenu(_ sender: Any) {
        
        menuLeadingEdge.constant = -228
        
        UIView.animate(withDuration: 0.2, animations: {
            self.hiddenDismissButton.alpha = 0.0
            self.view.layoutIfNeeded()
        })
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
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        let url = URL(string: "https://my.setmore.com/bookingpage/6e67a3dd-6628-421a-93c0-766663d17287".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        controller.webRequest = request
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func facebookButton(_ sender: UIButton) {
        
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
    
    @IBAction func twitterButton(_ sender: UIButton) {
        
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
    
    // collectionView Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.menuCollectionView.frame.width, height: 50)
    }
}
