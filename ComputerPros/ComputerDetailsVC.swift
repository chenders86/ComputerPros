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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = appleOrPC!
    }
    
    let computerNode = "Computers"
    var appleOrPC: String!
    var computerTypeNode: String?
    
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
    
    // Next session ask mentor about what is throwing this algorithm off by 20...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let verticalPaddingSpace = (self.flowLayout.minimumLineSpacing * 2) + (sectionInsets.top)
        let availableVerticalSpace = (self.view.frame.height) - (verticalPaddingSpace) - (self.navigationController?.navigationBar.frame.height)! - 30
        let heightPerItem = availableVerticalSpace / 3
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func fetchComputerDetails() {
        
        if let node = computerTypeNode {

            Database.database().reference().child(computerNode).child(appleOrPC).child(node).observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    if let urlString = dictionary["DetailedImageURL"] as? String {
                        let url = URL(string: urlString)
                        
                        DispatchQueue.global(qos: .userInteractive).async { // Need to cache images
                            if let imageData = NSData(contentsOf: url!) {
                                let computerImage = UIImage(data: imageData as Data)
                                let computer = DetailedComputerInfo()
                                computer.setValuesForKeys(dictionary)
                                computer.ComputerImage = computerImage
                                
                                DispatchQueue.main.async {
                                    self.computerArray.append(computer)
                                    self.computerArray.sort(by: { $0.Price! < $1.Price!})
                                    self.collectionView?.reloadData()
                                }
                            }
                        }
                    }
                }
            }, withCancel: nil)
        }
    }
}
