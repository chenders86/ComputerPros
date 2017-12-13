//
//  PCInventoryViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 12/5/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import UIKit
import Firebase
import ReachabilitySwift

class PCInventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let pcRef = Database.database().reference().child("Computers").child("PC")
    var activityIndicator: UIActivityIndicatorView!
    let reachability = Reachability()!
    var computerDisplayPropertiesArray = [ComputerDisplayProperties]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setNavBar()
        navigationController?.navigationBar.tintColor = UIColor(hue: 0.5361111111, saturation: 1.30, brightness: 0.85, alpha: 1.0)
        let aI: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            indicator.activityIndicatorViewStyle = .gray
            indicator.hidesWhenStopped = true
            indicator.center = CGPoint(x: (self.view.bounds.width / 2), y: ((tableView.center.y)))
            return indicator
        }()
        activityIndicator = aI
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkConnectionStatus()
        setupFirebaseObservers()
        self.tabBarController?.tabBar.isHidden = false
        print("PC VA")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        reachability.stopNotifier()
        pcRef.removeAllObservers()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computerDisplayPropertiesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PCCell", for: indexPath) as! PCTableViewCell
        let displayInfo = computerDisplayPropertiesArray[indexPath.row]
        
        cell.displayInfo = displayInfo
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let infoIndexPath = tableView.indexPathForSelectedRow!
        let nodeName = computerDisplayPropertiesArray[infoIndexPath.row].nodeName
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "computerDetailsVC") as! ComputerDetailsVC
        detailsVC.nodeName = nodeName
        detailsVC.appleOrPC = "PC"
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //        let availableVerticalSpace = view.frame.height
        //        let navigationControllerHeight = navigationController?.navigationBar.frame.height
        //        let tabBarHeight = tabBarController?.tabBar.frame.height
        //        let StatusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height)
        //        let visibleTableViewArea = (availableVerticalSpace - navigationControllerHeight! - tabBarHeight! - StatusBarHeight) // Fix crash when alertView presents
        //
        //        let cellHeight = visibleTableViewArea / CGFloat(computerDisplayPropertiesArray.count)
        //
        //        return cellHeight
        return CGFloat(69.25)
    }
    
    
    private func fbChildAdded() {
        
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        self.computerDisplayPropertiesArray.removeAll()
        
        pcRef.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let displayProperties = ComputerDisplayProperties()
                displayProperties.nodeName = snapshot.key
                displayProperties.displayName = dictionary["Name"] as? String
                if let urlString = dictionary["DetailedImageURL"] as? String {
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.setImageWithCacheOrURL(urlString: urlString, displayProperties: displayProperties)
                        DispatchQueue.main.async {
                            self.computerDisplayPropertiesArray.append(displayProperties)
                            self.computerDisplayPropertiesArray.sort(by: {$0.displayName! < $1.displayName!})
                            self.tableView.reloadData()
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }, withCancel: nil)
    }
    
    private func setupFirebaseObservers() {
        fbChildAdded()
    }
    
    private func setImageWithCacheOrURL(urlString: String, displayProperties: ComputerDisplayProperties) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            displayProperties.computerImage = cachedImage
            return
        } else {
            let url = URL(string: urlString)
            if let imageData = NSData(contentsOf: url!) {
                let downloadedImage = UIImage(data: imageData as Data)
                displayProperties.computerImage = downloadedImage
                imageCache.setObject(downloadedImage!, forKey: urlString as NSString)
            }
        }
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Check Connection", message: "Unable to establish connection with server", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkConnectionStatus() {
        
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.showAlert()
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func setNavBar() {
        let navItem = UINavigationItem(title: "PC")
        let doneItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        navItem.leftBarButtonItem = doneItem
        self.navigationController?.navigationBar.setItems([navItem], animated: false)
    }
    
    @objc private func done() {
        self.dismiss(animated: true, completion: nil)
    }
}
