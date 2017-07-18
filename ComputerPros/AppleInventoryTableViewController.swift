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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchComputerInfo()
    }
    
    //let computers = []()
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func fetchComputerInfo() {
        
        Database.database().reference().child("Computers").child("Apple").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let info = ComputerInfo()
                info.name = dictionary["Name"] as? String
                
                if let urlString = dictionary["ComputerImageURL"] as? String {
                    let url = URL(string: urlString)
                    if let imageData = NSData(contentsOf: url!) {
                        let computerImage = UIImage(data: imageData as Data)
                        info.computerImage = computerImage
                    }
                }
            }
            
        }, withCancel: nil)
        
    }
    
}
