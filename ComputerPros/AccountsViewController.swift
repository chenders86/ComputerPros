//
//  PasswordViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/27/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

class AccountsViewController: CoreDataTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Accounts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount))
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Account")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "accountName", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    let stack = CoreDataStack.sharedInstance()
    let cellID = "accountCell"
    
    @objc func newAccount() {
        
        let accountVC = self.storyboard?.instantiateViewController(withIdentifier: "addAccountVC") as! AddAccountViewController

        self.present(accountVC, animated: true, completion: nil)
    }
    
    
    // Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let acc = fetchedResultsController?.object(at: indexPath) as! Account
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = acc.accountName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let credentialsVC = self.storyboard?.instantiateViewController(withIdentifier: "credentialsVC") as? CredentialsViewController {
            
            let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginCredentials")
            
            fr.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]
            
            let indexPath = tableView.indexPathForSelectedRow!
            
            let account = fetchedResultsController?.object(at: indexPath) as? Account
            
            let pred = NSPredicate(format: "account = %@", argumentArray: [account!])
            
            fr.predicate = pred
            
            let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            
            credentialsVC.fetchedResultsController = fc
            
            credentialsVC.navigationItem.title = account?.accountName
            
            credentialsVC.account = account
            
            self.navigationController?.pushViewController(credentialsVC, animated: true)
        }
    }
    
    // Action
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let context = fetchedResultsController?.managedObjectContext, let account = fetchedResultsController?.object(at: indexPath) as? Account, editingStyle == .delete {
            context.delete(account)
            stack.save()
        }
    }
}
