//
//  ViewController.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 19/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import OAuth2
import Quartz
import CoreData

class MainViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    let center = NotificationCenter.default
    
    var container: NSPersistentContainer!
    
    // TODO: change VimeoData to CoreData?
//    var vimeoData: VimeoData = VimeoData();
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var logoutBtn: NSButton!
    
    lazy var loginViewController: LoginController = {
        return self.storyboard!.instantiateController(withIdentifier: "LoginViewController")
            as! LoginController
    }()
    
    lazy var loadingScreenController: LoadingOverlay = {
        return self.storyboard!.instantiateController(withIdentifier: "LoadingScreen")
            as! LoadingOverlay
    }()
    
    lazy var videoDetailController: VideoDetailController = {
        return self.storyboard!.instantiateController(withIdentifier: "VideoDetail")
            as! VideoDetailController
    }()
    
    //    var loginScreen : NSWindow;
    
    @IBAction func LogoutAction(_ sender: NSButton) {
        center.post(name: NSNotification.Name(rawValue: Notifications.AppUserLogOut), object: nil)
        sender.title = "Forgetting..."
        let loader = VimeoLoader()
        loader.oauth2.forgetTokens()
        sender.title = "Signed Out"
        sender.isEnabled = false;
        loginViewController.loader = loader;
        loginViewController.parentView = self;
        self.presentViewControllerAsSheet(loginViewController)
    }
    
    @IBAction func reqUserData(_ sender: NSButton) {
        
    }
    
    @IBAction func reqAlbumData(_ sender: NSButton) {
        
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.doubleAction = #selector(MainViewController.doubleClickOnResultRow)
        
        center.addObserver(forName: NSNotification.Name(rawValue: Notifications.VimeoLoadComplete), object: nil, queue: nil) { notification in
            self.reloadFileList()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func doubleClickOnResultRow()
    {
        guard (tableView.clickedRow != -1) else {
            print("selected an empty cell")
            return
        }
        
        // TODO: set as event > set to core data
        
        
        let item : VimeoVideoDataMO!
        
        let request = VimeoVideoDataMO.createFetchRequest()
        do {
            let vimeoVideoDataMO_Array = try self.container.viewContext.fetch(request)
            
            if (vimeoVideoDataMO_Array.count != 0) {
                item = vimeoVideoDataMO_Array[tableView.clickedRow]
                
                videoDetailController.vimeoVideoindex = tableView.clickedRow
                videoDetailController.vimeoVideoData = item
                
                self.presentViewControllerAsSheet(videoDetailController)
            }
            
        } catch {
            print("Fetch failed")
        }
        
        
        
        
//        let rowData = self.vimeoData.videoArray[tableView.clickedRow]
//        
//        videoDetailController.vimeoVideoindex = tableView.clickedRow
//        videoDetailController.vimeoVideoData = rowData
//        videoDetailController.loader = loader
//        self.presentViewControllerAsSheet(videoDetailController)
        
//        print(rowData.name)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func reloadFileList(){
        print("should reload")
        
        tableView.reloadData()
    }
    
    /** Forwards to `display(error:)`. */
    func show(_ error: Error) {
        if let error = error as? OAuth2Error {
            let err = NSError(domain: "OAuth2ErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: error.description])
            display(err)
        }
        else {
            display(error as NSError)
        }
    }
    
    /** Alert or log the given NSError. */
    func display(_ error: NSError) {
        if let window = self.view.window {
            NSAlert(error: error).beginSheetModal(for: window, completionHandler: nil)
            //            contentField?.stringValue = error.localizedDescription
        }
        else {
            NSLog("Error authorizing: \(error.description)")
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        let request = VimeoVideoDataMO.createFetchRequest()
        do {
            let vimeoVideoDataMO_Array = try self.container.viewContext.fetch(request)
            
            return vimeoVideoDataMO_Array.count
            
        } catch {
            print("Fetch failed")
            return 0
        }
    }
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "NameCellID"
        static let URLCell = "URLCellID"
        static let DurationCell = "DurationCellID"
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        let table = notification.object as! NSTableView
        
//        print(table.selectedRow, self.vimeoData.videoArray.count)
        
        guard (table.selectedRow != -1) else {
            print("selected an empty cell")
            return
        }
        
//        let rowData = self.vimeoData.videoArray[table.selectedRow]
        
        //		print(rowData.name)
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
                    text = item.changed.description
                    cellIdentifier = CellIdentifiers.NameCell
                } else if tableColumn == tableView.tableColumns[1] {
                    text = item.name!
                    cellIdentifier = CellIdentifiers.NameCell
                } else if tableColumn == tableView.tableColumns[2] {
                    text = item.link!
                    cellIdentifier = CellIdentifiers.URLCell
                } else if tableColumn == tableView.tableColumns[3] {
                    text = item.duration.description
                    cellIdentifier = CellIdentifiers.DurationCell
                }
            }
            
        } catch {
            print("Fetch failed")
        }
        
        // 3
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            //			cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
    
}

