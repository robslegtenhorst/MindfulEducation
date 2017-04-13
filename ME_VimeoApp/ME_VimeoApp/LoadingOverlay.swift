//
//  LoadingOverlay.swift
//  ME_VimeoApp
//
//  Created by Rob Slegtenhorst on 12/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import Cocoa
import OAuth2
import ProgressKit

class LoadingOverlay: NSViewController {
    
    //TODO error handling during load
    
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet var loadingIndicator: CircularProgressView!
    
    var loader : VimeoLoader!
    var parentView : ViewController!
    
    var percentagePerCall : CGFloat = 0;
    var callStep : CGFloat = 0;
    
    var vimeoData: VimeoData!;
    
    var usrLoaded = Bool(false)
    var albumsLoaded : Bool = false
    var videosLoaded = (Bool:false)
    var checkedLoadAmount : Bool = false
    
    var albumAmountLoaded : Bool = false
    var videoAmountLoaded : Bool = false
    
    var albumPagination : CGFloat = 0
    var videoPagination : CGFloat = 0
    
    func setPercentage()
    {
        if (percentagePerCall == 0)
        {
            let initCallAmount : CGFloat = 3
            let callAmount : CGFloat = initCallAmount + self.vimeoData.albumPages + self.vimeoData.videoPages
            let maxPerc : CGFloat = 1;
            
            percentagePerCall = maxPerc / callAmount
            
            callStep = 2
            
            loadingIndicator.progress = percentagePerCall * callStep
        } else {
            callStep += 1
            
            loadingIndicator.progress = percentagePerCall * callStep
        }
    }
    
    func loadData() {
        if (!usrLoaded && !albumsLoaded && !videosLoaded && !checkedLoadAmount)
        {
            checkLoadAmount()
        } else if (!usrLoaded && !albumsLoaded && !videosLoaded && checkedLoadAmount)
        {
            loadUserData()
        } else if (usrLoaded && !albumsLoaded && !videosLoaded && checkedLoadAmount)
        {
            loadAlbumsData()
        } else if (usrLoaded && albumsLoaded && !videosLoaded && checkedLoadAmount)
        {
            loadVideosData()
        } else if (usrLoaded && albumsLoaded && videosLoaded && checkedLoadAmount)
        {
            dismissViewController(self)
        }
    }
    
    func checkLoadAmount() {
        if (!albumAmountLoaded && !videoAmountLoaded)
        {
            loader.requestAlbumTotal() { dict, error in
                if let error = error {
                    switch error {
                    case OAuth2Error.requestCancelled:
                        self.statusLabel.insertText("Cancelled. Try Again.")
                    default:
                        self.statusLabel.insertText("Failed. Try Again.")
                        self.show(error)
                    }
                }
                else {
                    if let albumTotal = dict?["total"] as? CGFloat {
                        self.vimeoData.albumTotal = albumTotal
                        self.vimeoData.updatePagination(inputTotal: albumTotal, inputType: self.vimeoData.ALBUM)
                        
                        self.albumAmountLoaded = true
                        
                        self.checkLoadAmount()
                    }
                    NSLog("dict: \(dict)")
                    NSLog("Fetched album total: \(self.vimeoData.albumTotal)")
                    NSLog("Album total - Pages: \(self.vimeoData.albumPages)")
                }
            }
        } else if (albumAmountLoaded && !videoAmountLoaded)
        {
            loader.requestVideoTotal() { dict, error in
                if let error = error {
                    switch error {
                    case OAuth2Error.requestCancelled:
                        self.statusLabel.insertText("Cancelled. Try Again.")
                    default:
                        self.statusLabel.insertText("Failed. Try Again.")
                        self.show(error)
                    }
                }
                else {
                    if let videoTotal = dict?["total"] as? CGFloat {
                        self.vimeoData.videoTotal = videoTotal
                        self.vimeoData.updatePagination(inputTotal: videoTotal, inputType: self.vimeoData.VIDEO)
                        
                        self.videoAmountLoaded = true
                        self.checkedLoadAmount = true
                        
                        self.setPercentage()
                        
                        self.loadData()
                    }
                    NSLog("Fetched video total: \(self.vimeoData.videoTotal)")
                    NSLog("Video total - Pages: \(self.vimeoData.videoPages)")
                }
            }
        }
    }
    
    func loadUserData() {
        loader.requestUserdata() { dict, error in
            if let error = error {
                switch error {
                case OAuth2Error.requestCancelled:
                    self.statusLabel.insertText("Cancelled. Try Again.")
                default:
                    self.statusLabel.insertText("Failed. Try Again.")
                    self.show(error)
                }
            }
            else {
                self.vimeoData.userDict = dict
                self.vimeoData.vimeoUserData = VimeoUserData()
                
                var vimeoUserData = self.vimeoData.vimeoUserData
                vimeoUserData?.name = dict?["name"] as? NSString
                vimeoUserData?.link = dict?["link"] as? NSString
                
                if let pictures = dict?["pictures"] as? NSMutableDictionary {
                    
                    let imgArray = pictures["sizes"] as! NSArray;
                    
                    for i in 0 ..< imgArray.count
                    {
                        let dataDic = imgArray[i] as! NSMutableDictionary;
                        let width = dataDic["width"] as! NSNumber;
                        let link = dataDic["link"] as! NSString;
                        
                        switch width{
                        case 30:
                            vimeoUserData?.picture_30 = link
                        case 75:
                            vimeoUserData?.picture_75 = link
                        case 100:
                            vimeoUserData?.picture_100 = link
                        case 300:
                            vimeoUserData?.picture_300 = link
                        default:
                            return;
                        }
                    }
                    
                    self.usrLoaded = true
                    
                    self.setPercentage()
                    
                    self.loadData()
                }
                NSLog("Fetched user data: \(vimeoUserData?.name, vimeoUserData?.link, vimeoUserData?.picture_30)")
            }
        }
    }
    
    func loadAlbumsData() {
        
        if (albumPagination == 0)
        {
            albumPagination = 1
        } else {
            if (albumPagination != self.vimeoData.albumPages)
            {
                albumPagination = albumPagination + 1
            } else {
                self.albumsLoaded = true
                self.loadData()
            }
        }
        
        loader.requestUserAlbumData(page: albumPagination) { dict, error in
            if let error = error {
                switch error {
                case OAuth2Error.requestCancelled:
                    self.statusLabel.insertText("Cancelled. Try Again.")
                default:
                    self.statusLabel.insertText("Failed. Try Again.")
                    self.show(error)
                }
            }
            else {
                self.setPercentage()
                self.loadAlbumsData()
                
                NSLog("Fetched album data: \(self.albumPagination)")
                NSLog("-- Fetched album data: \(self.vimeoData.albumPages)")
                
            }
        }
    }
    
    func loadVideosData() {
        loader.requestUserdata() { dict, error in
            if let error = error {
                switch error {
                case OAuth2Error.requestCancelled:
                    self.statusLabel.insertText("Cancelled. Try Again.")
                default:
                    self.statusLabel.insertText("Failed. Try Again.")
                    self.show(error)
                }
            }
            else {
                
            }
        }
        
    }
    
    override func viewDidAppear() {
        loadingIndicator.progress = 0;
        loadData()
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
