//
//  CredentialsViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/5/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

class CredentialsViewController: CoreDataTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newCredentials))
    }
    
    var account: Account?
    
    let stack = CoreDataStack.sharedInstance()
    
    func newCredentials() {
        
        if self.account != nil {
            
            let addCredentialsVC = self.storyboard?.instantiateViewController(withIdentifier: "addCredentialsVC") as! AddCredentialsViewController
            
            addCredentialsVC.account = account
            
            self.present(addCredentialsVC, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let credentials = fetchedResultsController?.object(at: indexPath) as! LoginCredentials
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "credentialsCell") as! CredentialsCell
        
        cell.userActual.text = credentials.username
        cell.passwordActual.text = credentials.password
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let context = fetchedResultsController?.managedObjectContext, let note = fetchedResultsController?.object(at: indexPath) as? LoginCredentials, editingStyle == .delete {
            context.delete(note)
            stack.save()
        }
    }
}
