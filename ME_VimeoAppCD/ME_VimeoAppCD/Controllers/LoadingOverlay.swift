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
import CoreData

class LoadingOverlay: NSViewController {
    
    // TODO: error handling during load
    
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet var loadingIndicator: CircularProgressView!
    
    var loader : VimeoLoader!
    var parentView : MainViewController!
    
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
    
    let df : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
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
			parentView.vimeoData = self.vimeoData
			parentView.reloadFileList()
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
//                    NSLog("dict: \(dict)")
                    NSLog("Fetched album total: \(self.vimeoData.albumTotal)")
//                    NSLog("Album total - Pages: \(self.vimeoData.albumPages)")
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
//                    NSLog("Video total - Pages: \(self.vimeoData.videoPages)")
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
				
				vimeoUserData?.uri = dict?["uri"] as? NSString
				vimeoUserData?.resource_key = dict?["resource_key"] as? NSString
				
				vimeoUserData?.name = dict?["name"] as? NSString
				vimeoUserData?.link = dict?["link"] as? NSString
				
//				let appDelegate = NSApplication.shared().delegate as! AppDelegate
				
				guard let appDelegate = NSApplication.shared().delegate as? AppDelegate else {
						return
				}
				
				let managedContext = appDelegate.managedObjectContext
                let entity = NSEntityDescription.entity(forEntityName: "TestObject", in: managedContext)!
                let vimeoUserDataMO = NSManagedObject(entity: entity, insertInto: managedContext)
                
                print("MO Test 1")
                print(vimeoUserDataMO.value(forKey: "link"))
                
                vimeoUserDataMO.setValue(vimeoUserData?.link, forKeyPath: "link")
                
                print("MO Test 2")
                print(vimeoUserDataMO.value(forKey: "link"))
				
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
//                NSLog("Fetched user data: \(vimeoUserData?.name, vimeoUserData?.link, vimeoUserData?.picture_30)")
            }
        }
    }
    
    func processAlbumData (albumData:OAuth2JSON) {
		guard (albumData["data"] != nil) else {
			print("Processing Album Data Failed :: ")
			return
		}
		
        let albumArray = albumData["data"] as! NSArray;
        
        for i in 0 ..< albumArray.count
        {
            var vimeoAlbumData = VimeoAlbumData()
            vimeoAlbumData.dataDic = albumArray[i] as! NSMutableDictionary;
            vimeoAlbumData.uri = vimeoAlbumData.dataDic["uri"] as! NSString;
            vimeoAlbumData.name = vimeoAlbumData.dataDic["name"] as! NSString;
            vimeoAlbumData.link = vimeoAlbumData.dataDic["link"] as! NSString;
            vimeoAlbumData.duration = vimeoAlbumData.dataDic["duration"] as! NSNumber;
            
            vimeoAlbumData.created_time = df.date(from: vimeoAlbumData.dataDic["created_time"] as! String) as NSDate!
            vimeoAlbumData.modified_time = df.date(from: vimeoAlbumData.dataDic["modified_time"] as! String) as NSDate!
            self.vimeoData.albumArray.append(vimeoAlbumData)
        }
    }
    
    func requestUserAlbumData(page: CGFloat) {
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
                self.processAlbumData(albumData: dict!)
                self.setPercentage()
                self.loadAlbumsData()
            }
        }
    }
    
    func loadAlbumsData() {
        
        if (albumPagination == 0)
        {
            albumPagination = 1
            
            requestUserAlbumData(page:albumPagination)
            
        } else {
            if (albumPagination != self.vimeoData.albumPages)
            {
                albumPagination = albumPagination + 1
                
                requestUserAlbumData(page:albumPagination)
                
            } else {
                self.albumsLoaded = true
                self.loadData()
            }
        }
    }
    
    func processvideoData (videoData:OAuth2JSON) {
		guard (videoData["data"] != nil) else {
			print("Processing Video Data Failed :: ")
			return
		}
		
		let videoArray = videoData["data"] as! NSArray
		
//		print(videoData)
		
        for i in 0 ..< videoArray.count
        {
            // TODO: add in all items from returned data
            var vimeoVideoData = VimeoVideoData()
            vimeoVideoData.dataDic = videoArray[i] as! NSMutableDictionary;
			
			let status = vimeoVideoData.dataDic["status"] as! NSString
			
			if (status == "uploading"){
				return
			} else {
            
				vimeoVideoData.uri = vimeoVideoData.dataDic["uri"] as! NSString;
				vimeoVideoData.name = vimeoVideoData.dataDic["name"] as! NSString;
				vimeoVideoData.link = vimeoVideoData.dataDic["link"] as! NSString;
				
				vimeoVideoData.duration = vimeoVideoData.dataDic["duration"] as! NSNumber;
				
				vimeoVideoData.width = vimeoVideoData.dataDic["width"] as! NSNumber;
				vimeoVideoData.height = vimeoVideoData.dataDic["height"] as! NSNumber;
				
				vimeoVideoData.created_time = df.date(from: vimeoVideoData.dataDic["created_time"] as! String) as NSDate!
				vimeoVideoData.modified_time = df.date(from: vimeoVideoData.dataDic["modified_time"] as! String) as NSDate!
				vimeoVideoData.release_time = df.date(from: vimeoVideoData.dataDic["release_time"] as! String) as NSDate!
				
				// Subs
				let tempMetadataDict = vimeoVideoData.dataDic["metadata"] as! NSMutableDictionary;
				let tempConnectionsDict = tempMetadataDict["connections"] as! NSMutableDictionary;
				let tempTexttracksDict = tempConnectionsDict["texttracks"] as! NSMutableDictionary;
				
				vimeoVideoData.texttracks_uri = tempTexttracksDict["uri"] as! NSString
				vimeoVideoData.texttracks_total = tempTexttracksDict["total"] as! NSNumber
				
//				print(vimeoVideoData.texttracks_uri)
				
				
				// Pictures
				let tempPictDict = vimeoVideoData.dataDic["pictures"] as! NSMutableDictionary;
					
				let pictureSizeArray = tempPictDict["sizes"] as! NSArray;
				
				for j in 0 ..< pictureSizeArray.count
				{
					let tempPictSizeDict = pictureSizeArray[j] as! NSMutableDictionary;
					let tempWidth = tempPictSizeDict["width"] as! NSNumber
					let tempUrl = tempPictSizeDict["link"] as! NSString
					
					switch tempWidth {
					case 100:
						vimeoVideoData.thumb_url_100x75 = tempUrl
					case 200:
						vimeoVideoData.thumb_url_200x150 = tempUrl
					case 295:
						vimeoVideoData.thumb_url_295x166 = tempUrl
					case 640:
						vimeoVideoData.thumb_url_640x360 = tempUrl
					case 960:
						vimeoVideoData.thumb_url_960x540 = tempUrl
					case 1280:
						vimeoVideoData.thumb_url_1280x720 = tempUrl
					default:
						return
					}
				}
				
				self.vimeoData.videoArray.append(vimeoVideoData)
//				print("array length :: "+self.vimeoData.videoArray.count.description)
			}
        }
    }
    
    func requestVideoData(page: CGFloat) {
        print("Requesting page: "+page.description)
        loader.requestVideoData(page: videoPagination) { dict, error in
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
                self.processvideoData(videoData: dict!)
                self.setPercentage()
                self.loadVideosData()
            }
        }
    }
    
    func loadVideosData() {
        if (videoPagination == 0)
        {
            videoPagination = 1
            
            requestVideoData(page:videoPagination)
            
        } else {
            if (videoPagination != self.vimeoData.videoPages)
            {
                videoPagination = videoPagination + 1
                
                requestVideoData(page:videoPagination)
                
            } else {
                self.videosLoaded = true
                self.loadData()
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
