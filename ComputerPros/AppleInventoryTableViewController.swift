//
//  AppleInventoryTableViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/17/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class AppleInventoryTVC: UITableViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchAppleComputerInfo()
    }
    
    
    var computerInfoArray = [ComputerInfo]()
    
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computerInfoArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "appleCell", for: indexPath) as! AppleTableViewCell
        let info = computerInfoArray[indexPath.row]
        
        cell.computerInfo = info
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let infoIndexPath = tableView.indexPathForSelectedRow!
        let computerNode = computerInfoArray[infoIndexPath.row].nodeName
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "computerDetailsVC") as! ComputerDetailsVC
        detailsVC.computerTypeNode = computerNode
        detailsVC.appleOrPC = "Apple"
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let availableVerticalSpace = view.frame.height
        let navigationControllerHeight = navigationController?.navigationBar.frame.height
        let tabBarHeight = tabBarController?.tabBar.frame.height
        let statusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height)
        let visibleTableViewArea = (availableVerticalSpace - navigationControllerHeight! - tabBarHeight! - statusBarHeight)
        
        let cellHeight = visibleTableViewArea / CGFloat(computerInfoArray.count)
        
        return cellHeight
    }
    
    
    private func fetchAppleComputerInfo() { // Check connection status and load only when finished
        
        let activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            indicator.activityIndicatorViewStyle = .gray
            indicator.hidesWhenStopped = true
            indicator.center = CGPoint(x: tableView.center.x, y: ((tableView.center.y) - (tabBarController?.tabBar.frame.height)!))
            return indicator
        }()
        
        
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        self.computerInfoArray.removeAll()
        
        Database.database().reference().child("Computers").child("Apple").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let info = ComputerInfo()
                info.nodeName = snapshot.key
                info.name = dictionary["Name"] as? String
                
                if let urlString = dictionary["ComputerImageURL"] as? String {
                    
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.setImageWithCacheOrURL(urlString: urlString, info: info)
                        if let displayOrder = dictionary["DisplayOrder"] as? Int {
                            info.displayOrder = displayOrder
                            
                            DispatchQueue.main.async {
                                self.computerInfoArray.append(info)
                                self.computerInfoArray.sort(by: { $0.displayOrder! < $1.displayOrder!})
                                self.stopActivityIndicator(snapshot: snapshot, activityIndicator: activityIndicator)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }, withCancel: nil)
    }
    
    private func setImageWithCacheOrURL(urlString: String, info: ComputerInfo) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            info.computerImage = cachedImage
            return
        } else {
            let url = URL(string: urlString)
            if let imageData = NSData(contentsOf: url!) {
                let downloadedImage = UIImage(data: imageData as Data)
                info.computerImage = downloadedImage
                imageCache.setObject(downloadedImage!, forKey: urlString as NSString)
            }
        }
    }
    
    private func stopActivityIndicator(snapshot: DataSnapshot, activityIndicator: UIActivityIndicatorView) {
        
        if self.computerInfoArray.count == Int(snapshot.childrenCount) {
            activityIndicator.stopAnimating()
        }
    }
}
