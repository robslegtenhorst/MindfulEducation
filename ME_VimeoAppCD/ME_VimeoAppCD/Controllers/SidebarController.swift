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

class SidebarController: NSViewController {
    
    var container: NSPersistentContainer!
    
    @IBOutlet weak var menuSidebarView: NSTableView!
    
    @IBOutlet weak var tempTable: NSTableView!
    
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
    
}

extension SidebarController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        let request = VimeoAlbumDataMO.createFetchRequest()
        do {
            let vimeoAlbumDataMO_Array = try self.container.viewContext.fetch(request)
            
            if (vimeoAlbumDataMO_Array.count != 0) {
                return vimeoAlbumDataMO_Array.count
            } else {
                return 0
            }
            
        } catch {
            print("Fetch failed")
            return 0
        }
    }
}

extension SidebarController: NSTableViewDelegate {
    fileprivate enum CellIdentifiers {
        static let NameCell = "NameCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        tableView.backgroundColor = .clear
        //        tableView.selectionHighlightStyle = .none
        
        var text: String = ""
        var cellIdentifier: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        // 1
        let item : VimeoAlbumDataMO!
        
        let request = VimeoAlbumDataMO.createFetchRequest()
        do {
            let vimeoAlbumDataMO_Array = try self.container.viewContext.fetch(request)
            
            if (vimeoAlbumDataMO_Array.count != 0) {
                item = vimeoAlbumDataMO_Array[row]
                
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
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? SideBarCell {
            //            print("text :: "+text)
            
            cell.textField?.stringValue = text
            //			cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        let table = notification.object as! NSTableView
        
        guard (table.selectedRow != -1) else {
            print("selected an empty cell")
            return
        }
        
        let cell = table.view(atColumn: 0, row:table.selectedRow, makeIfNecessary:true) as? SideBarCell
        
        cell?.setSelected()
    }
}
