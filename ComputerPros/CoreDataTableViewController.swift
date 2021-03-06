//
//  CoreDataTableViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/3/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

class CoreDataTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet{
            fetchedResultsController?.delegate = self
            executeSearch()
            tableView.reloadData()
        }
    }
    
    init(fetchedResultsController fc: NSFetchedResultsController<NSFetchRequestResult>, style: UITableViewStyle = .plain) {
        fetchedResultsController = fc
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // TableView Delegates
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        let fc = fetchedResultsController != nil ? fetchedResultsController?.sections?.count : 0
        
        return fc!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let fc = fetchedResultsController != nil ? fetchedResultsController?.sections?[section].numberOfObjects : 0
        
        return fc!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let fc = fetchedResultsController != nil ? fetchedResultsController?.sections?[section].name : nil
        
        return fc!
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        let fc = fetchedResultsController != nil ? fetchedResultsController?.section(forSectionIndexTitle: title, at: index) : 0
        
        return fc!
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        let fc = fetchedResultsController != nil ? fetchedResultsController?.sectionIndexTitles : nil
        
        return fc!
    }
    
    // FetchedResults Delegates
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let set = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(set, with: .fade)
        case .delete:
            tableView.deleteSections(set, with: .fade)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // Utilities
    
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(String(describing: fetchedResultsController))")
            }
        }
    }
}
