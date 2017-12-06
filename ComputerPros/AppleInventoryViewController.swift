//
//  AppleInventoryViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 12/5/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import UIKit
import Firebase
import ReachabilitySwift

class AppleInventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appleRef = Database.database().reference().child("Computers").child("Apple")
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkConnectionStatus()
        setupFirebaseObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        reachability.stopNotifier()
        appleRef.removeAllObservers()
    }
    
    deinit {
        print("Apple viewController Deinit")
    }
    
    let reachability = Reachability()!
    var computerDisplayPropertiesArray = [ComputerDisplayProperties]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computerDisplayPropertiesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "appleCell", for: indexPath) as! AppleTableViewCell
        let displayInfo = computerDisplayPropertiesArray[indexPath.row]
        
        cell.displayInfo = displayInfo
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let infoIndexPath = tableView.indexPathForSelectedRow!
        let nodeName = computerDisplayPropertiesArray[infoIndexPath.row].nodeName
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "computerDetailsVC") as! ComputerDetailsVC
        detailsVC.nodeName = nodeName
        detailsVC.appleOrPC = "Apple"
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //        let availableVerticalSpace = UIScreen.main.bounds.height
        //        let navigationControllerHeight = navigationController?.navigationBar.frame.height
        //        let tabBarHeight = tabBarController?.tabBar.frame.height
        //        let statusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height)
        //        let visibleTableViewArea = (availableVerticalSpace - navigationControllerHeight! - tabBarHeight! - statusBarHeight)
        //
        //        let cellHeight = visibleTableViewArea / CGFloat(computerDisplayPropertiesArray.count)
        //        print(cellHeight)
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
        
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        self.computerDisplayPropertiesArray.removeAll()
        
        appleRef.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let displayProperties = ComputerDisplayProperties()
                displayProperties.nodeName = snapshot.key
                displayProperties.displayName = dictionary["Name"] as? String
                
                if let urlString = dictionary["ComputerImageURL"] as? String {
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        self.setImageWithCacheOrURL(urlString: urlString, displayProperties: displayProperties)
                        if let displayOrder = dictionary["DisplayOrder"] as? Int {
                            displayProperties.displayOrder = displayOrder
                            self.computerDisplayPropertiesArray.append(displayProperties)
                            self.computerDisplayPropertiesArray.sort(by: {$0.displayOrder! < $1.displayOrder!})
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.stopActivityIndicator(snapshot: snapshot, activityIndicator: activityIndicator)
                                print("Array count after addChild reloadData: \(self.computerDisplayPropertiesArray.count)")
                            }
                        }
                    }
                }
            }
        }, withCancel: nil)
    }
    
    private func fbChildRemoved() {
        
        appleRef.observe(.childRemoved) { (snapshot) in
            print(snapshot.childrenCount)
            
            if let nodeName = snapshot.key as String? {
                print("Removed nodeName: \(nodeName)")
                for displayProperty in self.computerDisplayPropertiesArray {
                    if displayProperty.nodeName == nodeName {
                        let index = self.computerDisplayPropertiesArray.index(of: displayProperty)
                        self.computerDisplayPropertiesArray.remove(at: index!)
                        self.computerDisplayPropertiesArray.sort(by: {$0.displayOrder! < $1.displayOrder!})
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        print("nodeName doesn't exist!")
                    }
                }
            }
        }
    }
    
    //    private func fbChildChanged() {
    //
    //        appleRef.observe(.childChanged) { (snapshot) in
    //
    //
    //        }
    //    }
    
    private func setupFirebaseObservers() {
        fbChildAdded()
        fbChildRemoved()
        //fbChildChanged()
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
        
        if self.computerDisplayPropertiesArray.count == snapshot.childrenCount {
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

