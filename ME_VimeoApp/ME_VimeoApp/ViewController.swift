//
//  ViewController.swift
//  ME_VimeoApp
//
//  Created by Rob Slegtenhorst on 11/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import OAuth2
import Quartz

class ViewController: NSViewController {
    
    var loader: VimeoLoader = VimeoLoader();
    
    var vimeoData: VimeoData = VimeoData();
    
    @IBOutlet weak var logoutBtn: NSButton!
    
    lazy var loginViewController: LoginController = {
        return self.storyboard!.instantiateController(withIdentifier: "LoginViewController")
            as! LoginController
    }()
    
    lazy var loadingScreenController: LoadingOverlay = {
        return self.storyboard!.instantiateController(withIdentifier: "LoadingScreen")
            as! LoadingOverlay
    }()
    
//    var loginScreen : NSWindow;
    
    @IBAction func LogoutAction(_ sender: NSButton) {
        sender.title = "Forgetting..."
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
    
    func startLoading() {
        loadingScreenController.loader = loader;
        loadingScreenController.parentView = self;
        loadingScreenController.vimeoData = vimeoData;
        self.presentViewControllerAsSheet(loadingScreenController)
    }
    
    override func viewDidAppear() {
        
//        loader.oauth2.forgetTokens()
        
        if (loader.oauth2.hasUnexpiredAccessToken() == true){
            print("signed in")
            startLoading()
        } else {
            print("need to sign in")
            self.presentViewControllerAsSheet(loginViewController)
            loginViewController.loader = loader;
            loginViewController.parentView = self;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
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


}

