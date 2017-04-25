//
//  SidebarController.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 24/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

class SidebarController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var container: NSPersistentContainer!
    
    @IBOutlet weak var menuSidebarView: NSTableView!
    
    func testCall() {
        print("called function")
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = NSPersistentContainer(name: "ME_VimeoAppCD")
        
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        menuSidebarView.delegate = self
        menuSidebarView.dataSource = self
        
        menuSidebarView.doubleAction = #selector(SidebarController.doubleClickOnResultRow)
        
    }
    
    func doubleClickOnResultRow()
    {
        guard (menuSidebarView.clickedRow != -1) else {
            print("selected an empty cell")
            return
        }
        
        print(menuSidebarView.clickedRow)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func reloadFileList(){
        menuSidebarView.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        let request = VimeoVideoDataMO.createFetchRequest()
        do {
            let vimeoVideoDataMO_Array = try self.container.viewContext.fetch(request)
            
            if (vimeoVideoDataMO_Array.count != 0) {
                return vimeoVideoDataMO_Array.count
            } else {
                return 0
            }
            
        } catch {
            print("Fetch failed")
        }
        
        return 0
    }
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "NameCellID"
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        let table = notification.object as! NSTableView
        
        //        print(table.selectedRow, self.vimeoData.videoArray.count)
        
        guard (table.selectedRow != -1) else {
            print("selected an empty cell")
            return
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = ""
        var cellIdentifier: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        // 1
        let item : VimeoVideoDataMO!
        
        let request = VimeoVideoDataMO.createFetchRequest()
        do {
            let vimeoVideoDataMO_Array = try self.container.viewContext.fetch(request)
            
            if (vimeoVideoDataMO_Array.count != 0) {
                item = vimeoVideoDataMO_Array[row]
                
                // 2
                if tableColumn == tableView.tableColumns[0] {
                    text = item.name!
                    cellIdentifier = CellIdentifiers.NameCell
                }
            }
            
        } catch {
            print("Fetch failed")
        }
        
        // 3
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            print("text :: "+text)
            cell.textField?.stringValue = text
            //			cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
}
