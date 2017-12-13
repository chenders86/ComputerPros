//
//  ComputerDetailsVC.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/19/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ComputerDetailsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComputerDetails()
        self.flowLayout.minimumLineSpacing = 16
        self.flowLayout.collectionView?.alwaysBounceVertical = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = appleOrPC!
    }
    
    let computerNode = "Computers"
    var appleOrPC: String?
    var nodeName: String?
    
    var computerArray = [DetailedComputerInfo]()
    
    let sectionInsets = UIEdgeInsets(top: 16.0, left: 10.0, bottom: 0.0, right: 10.0)
    let itemsPerRow: CGFloat = 1
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return computerArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "computerDetailsCell", for: indexPath) as! ComputerDetailsCell
        let computerInfo = computerArray[indexPath.row]
        
        cell.detailedComputerInfo = computerInfo
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let verticalPaddingSpace = (self.flowLayout.minimumLineSpacing * 2) + (sectionInsets.top)
        let statusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height)
        let availableVerticalSpace = (self.view.frame.height) - (verticalPaddingSpace) - (navigationController?.navigationBar.frame.height)! - statusBarHeight
        let heightPerItem = availableVerticalSpace / 3
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    @objc func fetchComputerDetails() {
        
        if let brand = appleOrPC, brand == "Apple" {
            
            if let node = nodeName {
                
                Database.database().reference().child(computerNode).child(appleOrPC!).child(node).observe(.childAdded, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        
                        if let urlString = dictionary["DetailedImageURL"] as? String {
                            
                            DispatchQueue.global(qos: .userInteractive).async {
                                let computerInfo = DetailedComputerInfo()
                                computerInfo.setValuesForKeys(dictionary)
                                self.setImageWithCacheOrURL(urlString: urlString, info: computerInfo)
                                
                                DispatchQueue.main.async {
                                    self.computerArray.append(computerInfo)
                                    self.computerArray.sort(by: {$0.Price! < $1.Price!})
                                    self.collectionView?.reloadData()
                                }
                            }
                        }
                    }
                }, withCancel: nil)
            }
        } else if let brand = appleOrPC, brand == "PC" {
            
            Database.database().reference().child(computerNode).observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    if let node = self.nodeName {
                        
                        if let computerType = dictionary[node] as? [String: AnyObject] {
                            
                            if let urlString = computerType["DetailedImageURL"] as? String {
                                
                                DispatchQueue.global(qos: .userInteractive).async {
                                    let computerInfo = DetailedComputerInfo()
                                    computerInfo.setValuesForKeys(computerType)
                                    self.setImageWithCacheOrURL(urlString: urlString, info: computerInfo)
                                    
                                    DispatchQueue.main.async {
                                        self.computerArray.append(computerInfo)
                                        self.collectionView?.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }, withCancel: nil)
            
        }
    }
    
    private func setImageWithCacheOrURL(urlString: String, info: DetailedComputerInfo) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            info.ComputerImage = cachedImage
            return
        } else {
            let url = URL(string: urlString)
            if let imageData = NSData(contentsOf: url!) {
                let downloadedImage = UIImage(data: imageData as Data)
                info.ComputerImage = downloadedImage
                imageCache.setObject(downloadedImage!, forKey: urlString as NSString)
            }
        }
    }
}
