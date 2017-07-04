//
//  PasswordViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/27/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

class PasswordViewController: CoreDataTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Password Keeper"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount))
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Account")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "accountName", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        addHiddenButton()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    let cellID = "accountCell"
    
    let hiddenButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.black
        btn.addTarget(self, action: #selector(dismissNewAccountPopIn), for: .touchUpInside)
        return btn
    }()
    
    func newAccount() {
        
        print("addedAccount!")
        
    }
    
    func dismissNewAccountPopIn() {
        
        print("dismissedPopIn")
    }
    
    // Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let acc = fetchedResultsController?.object(at: indexPath) as! Account
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = acc.accountName
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    // Action
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let context = fetchedResultsController?.managedObjectContext, let account = fetchedResultsController?.object(at: indexPath) as? Account, editingStyle == .delete {
            context.delete(account)
        }
    }
}
