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

class AppleInventoryTVC: UITableViewController { // Would possibly like to update tableView only once the data has finished downloading
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchAppleComputerInfo() // Is this be better? Try caching?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchAppleComputerInfo()
    }
    
    
    var computerInfoArray = [ComputerInfo]()

        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computerInfoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "appleTVCell", for: indexPath) as! AppleTableViewCell
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
        return CGFloat(70)
    }
    
    
    func fetchAppleComputerInfo() {
        
        self.computerInfoArray.removeAll()
        
        Database.database().reference().child("Computers").child("Apple").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let info = ComputerInfo()
                info.nodeName = snapshot.key
                info.name = dictionary["Name"] as? String
                
                if let urlString = dictionary["ComputerImageURL"] as? String {
                    let url = URL(string: urlString)
                    
                    DispatchQueue.global(qos: .userInteractive).async {
                        if let imageData = NSData(contentsOf: url!) {
                            let computerImage = UIImage(data: imageData as Data)
                            info.computerImage = computerImage
                            if let displayOrder = dictionary["DisplayOrder"] as? Int {
                                info.displayOrder = displayOrder
                                self.computerInfoArray.append(info) // This crashes 1/50 times: UnsafeMutablePointer.deinitialize with negative count
                                
                                DispatchQueue.main.async {
                                    self.computerInfoArray.sort(by: { $0.displayOrder! < $1.displayOrder!})
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }, withCancel: nil)
    }
}
