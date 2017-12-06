//
//  PCInventoryTableViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/17/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import UIKit
import Firebase
import ReachabilitySwift

class PCInventoryTVC: UITableViewController {

    let pcRef = Database.database().reference().child("Computers").child("PC")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkConnectionStatus()
        setupFirebaseObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        reachability.stopNotifier()
    }
    
    deinit {
        pcRef.removeAllObservers()
        print("PC TVC Deinit")
    }
    
    let reachability = Reachability()!
    var computerDisplayPropertiesArray = [ComputerDisplayProperties]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computerDisplayPropertiesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PCCell", for: indexPath) as! PCTableViewCell
        let displayInfo = computerDisplayPropertiesArray[indexPath.row]
        
        cell.displayInfo = displayInfo
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let infoIndexPath = tableView.indexPathForSelectedRow!
        let nodeName = computerDisplayPropertiesArray[infoIndexPath.row].nodeName
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "computerDetailsVC") as! ComputerDetailsVC
        detailsVC.nodeName = nodeName
        detailsVC.appleOrPC = "PC"
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
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
        
        let activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            indicator.activityIndicatorViewStyle = .gray
            indicator.hidesWhenStopped = true
            indicator.center = CGPoint(x: tableView.center.x, y: ((tableView.center.y) - (tabBarController?.tabBar.frame.height)!))
            return indicator
        }()
        
        
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
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
                            self.stopActivityIndicator(snapshot: snapshot, activityIndicator: activityIndicator)
                            self.tableView.reloadData()
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
    
    private func stopActivityIndicator(snapshot: DataSnapshot, activityIndicator: UIActivityIndicatorView) {
        
        if self.computerDisplayPropertiesArray.count == Int(snapshot.childrenCount) {
            activityIndicator.stopAnimating()
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
}
