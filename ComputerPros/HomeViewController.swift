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
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        menuView.layer.shadowOffset = CGSize(width: 0, height: 9)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // Outlets
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var gigabyteLabel: UILabel!
    @IBOutlet weak var progressBar: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuLeadingEdge: NSLayoutConstraint!
    @IBOutlet weak var hiddenDismissButton: UIButton!
    
    let menuCellID = "menuCell"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name: .Home, imageName: "Home"), Setting(name: .ProCare, imageName: "CloudMenu"), Setting(name: .Inventory, imageName: "Inventory"), Setting(name: .Onsite, imageName: "OnSiteCalendar"), Setting(name: .Password, imageName: "PassKey"), Setting(name: .Contact, imageName: "ContactUs")]
    }()
    
    
    // Actions
    @IBAction func hamburgerMenu(_ sender: UIButton) {
        
        menuLeadingEdge.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.hiddenDismissButton.alpha = 0.25
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func dismissMenu(_ sender: Any) {
        
        menuLeadingEdge.constant = -228
        
        UIView.animate(withDuration: 0.2, animations: {
            self.hiddenDismissButton.alpha = 0
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func appleButton(_ sender: UIButton) {
        
        showAppleCom()
    }
    
    @IBAction func windowsButton(_ sender: UIButton) {
        
        showMicrosoftCom()
    }
    
    @IBAction func bookItButton(_ sender: UIButton) {
        
        showSetmore()
    }
    
    @IBAction func facebookButton(_ sender: UIButton) {
        
        showFacebook()
    }
    
    @IBAction func twitterButton(_ sender: UIButton) {
        
        showTwitter()
    }
    
    // collectionView Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.menuCollectionView.dequeueReusableCell(withReuseIdentifier: menuCellID, for: indexPath) as! MenuCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = settings[indexPath.item]
        
        presentViewControllerForName(menuCellName: setting.name)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.menuCollectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
