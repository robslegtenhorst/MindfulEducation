//
//  MainSplitViewController.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 25/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import OAuth2

class MainSplitViewController: NSSplitViewController {
    
    var loader : VimeoLoader!
    
    let center = NotificationCenter.default
    
    var menuSplitViewController : SidebarController!
    
    // TODO: change VimeoData to CoreData?
    
    lazy var loginViewController: LoginController = {
        return self.storyboard!.instantiateController(withIdentifier: "LoginViewController")
            as! LoginController
    }()
    
    lazy var loadingScreenController: LoadingDataOverlay = {
        return self.storyboard!.instantiateController(withIdentifier: "LoadingDataScreen")
            as! LoadingDataOverlay
    }()
    
    @IBOutlet weak var menuSplitView: NSSplitViewItem!
    
    func startLoading() {
        self.presentViewControllerAsSheet(loadingScreenController)
    }
    
    func logOut() {
        self.presentViewControllerAsSheet(loadingScreenController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        center.addObserver(forName: NSNotification.Name(rawValue: Notifications.AppUserLogIn), object: nil, queue: nil) { notification in
            print("\(notification.name): \(notification.userInfo ?? [:])")
        }
        
        center.addObserver(forName: NSNotification.Name(rawValue: Notifications.AppUserLogOut), object: nil, queue: nil) { notification in
            print("\(notification.name): \(notification.userInfo ?? [:])")
        }
        
        center.addObserver(forName: NSNotification.Name(rawValue: Notifications.AppDataReloadStart), object: nil, queue: nil) { notification in
            self.startLoading()
        }
        
        center.addObserver(forName: NSNotification.Name(rawValue: Notifications.AppDataReloadComplete), object: nil, queue: nil) { notification in
            print("\(notification.name): \(notification.userInfo ?? [:])")
        }
        
        center.addObserver(forName: NSNotification.Name(rawValue: Notifications.VimeoLoadComplete), object: nil, queue: nil) { notification in
            print("\(notification.name): \(notification.userInfo ?? [:])")
        }
        
    }
    
    override func viewDidAppear() {
        loader = VimeoLoader()
        
        if (loader.oauth2.hasUnexpiredAccessToken() == true){
            print("signed in")
            center.post(name: NSNotification.Name(rawValue: Notifications.AppDataReloadStart), object: nil)
        } else {
            print("need to sign in")
            center.post(name: NSNotification.Name(rawValue: Notifications.AppUserLogIn), object: nil)
        }
    }
    
}
