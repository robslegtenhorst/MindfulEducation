//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Rob Slegtenhorst on 18/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import CoreData

class ViewController: NSViewController {
    
    var container: NSPersistentContainer!
    var commits = [Commit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = NSPersistentContainer(name: "CoreDataTest")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }

//        fakeLoad()
        
        print(commits.count)
        
        loadSavedData()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func loadSavedData() {
        let request = Commit.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            commits = try container.viewContext.fetch(request)
            
            for commit in commits {
                print(commit.message)
            }
            
            print("Got \(commits.count) commits")
//            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }


}

