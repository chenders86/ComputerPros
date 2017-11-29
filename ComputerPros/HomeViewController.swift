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
        menuView.backgroundColor = UIColor.lightGray
        menuView.layer.shadowOffset = CGSize(width: 0, height: 9)
        addSwipeToMenu()
        navigationController?.navigationBar.tintColor = UIColor(hue: 0.5361111111, saturation: 1.30, brightness: 0.85, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // Outlets
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuLeadingEdge: NSLayoutConstraint!
    @IBOutlet weak var hiddenDismissButton: UIButton!
    
    let menuCellID = "menuCell"
    let cellHeight: CGFloat = 50
    
    let MenuCellSettingArray: [MenuCellSettings] = {
        return [MenuCellSettings(name: .Home, imageName: "Home"), MenuCellSettings(name: .ProCare, imageName: "CloudMenu"), MenuCellSettings(name: .Inventory, imageName: "Inventory"), MenuCellSettings(name: .Password, imageName: "PassKey"), MenuCellSettings(name: .Contact, imageName: "ContactUs"), MenuCellSettings(name: .Onsite, imageName: "OnSiteCalendar")]
    }()
    
    
    // Actions
    @IBAction func hamburgerMenu(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuLeadingEdge.constant = 0
            self.hiddenDismissButton.alpha = 0.50
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func dismissMenu(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.menuLeadingEdge.constant = -228
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
    
    @IBAction func cloudButtonPressed(_ sender: UIButton) {
        showProCare()
    }
    
    @IBAction func facebookButton(_ sender: UIButton) {
        showFacebook()
    }
    
    @IBAction func twitterButton(_ sender: UIButton) {
        showTwitter()
    }
    
    // collectionView Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuCellSettingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: menuCellID, for: indexPath) as! MenuCell
        
        let cellSettings = MenuCellSettingArray[indexPath.item]
        cell.setting = cellSettings
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = MenuCellSettingArray[indexPath.item]
        
        presentViewControllerForName(menuCellName: setting.name)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuCollectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
