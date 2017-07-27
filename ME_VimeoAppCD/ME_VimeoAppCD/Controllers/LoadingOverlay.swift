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
    
    let center = NotificationCenter.default
    
    var container: NSPersistentContainer!
    
    // TODO: error handling during load
    
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet var loadingIndicator: CircularProgressView!
    
    var loader : VimeoLoader!
    var parentView : MainViewController!
    
    var percentagePerCall : CGFloat = 0;
    var callStep : CGFloat = 0;
    
    // TODO: change VimeoData to CoreData? 
    var vimeoData: VimeoData!;
    
    var usrLoaded = Bool(false)
    var albumsLoaded : Bool = false
    var videosLoaded : Bool = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = NSPersistentContainer(name: "ME_VimeoAppCD")
        
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        deleteCoreData()
    }
    
    func deleteCoreData() {
        
        //TODO Empty out current coredata set
        // create the delete request for the specified entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VimeoVideoDataMO")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // perform the delete
        do {
            try container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
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
        
        center.post(name: NSNotification.Name(rawValue: Notifications.VimeoLoadStarted), object: nil)
        
        if (!usrLoaded && !albumsLoaded && !videosLoaded)
        {
            loadUserData()
        } else if (usrLoaded && !albumsLoaded && !videosLoaded)
        {
            loadAlbumsData()
        } else if (usrLoaded && albumsLoaded && !videosLoaded)
        {
            loadVideosData()
        } else if (usrLoaded && albumsLoaded && videosLoaded)
        {
            center.post(name: NSNotification.Name(rawValue: Notifications.VimeoLoadComplete), object: nil)
            dismissViewController(self)
//			parentView.vimeoData = self.vimeoData
			parentView.reloadFileList()
        }
    }
    
    func processUserData (userData:OAuth2JSON) {
        let vimeoUserDataMO_addUser = VimeoUserDataMO(context: self.container.viewContext)
        
        vimeoUserDataMO_addUser.uri = userData["uri"] as? String
        vimeoUserDataMO_addUser.resource_key = userData["resource_key"] as? String
        vimeoData.vimeoUserResource_key = vimeoUserDataMO_addUser.resource_key
        
        vimeoUserDataMO_addUser.name = userData["name"] as? String
        vimeoUserDataMO_addUser.link = userData["link"] as? String
        
        if let pictures = userData["pictures"] as? NSDictionary {
            
            let imgArray = pictures["sizes"] as! NSArray;
            
            for i in 0 ..< imgArray.count
            {
                let dataDic = imgArray[i] as! NSDictionary;
                let width = dataDic["width"] as! NSNumber;
                let link = dataDic["link"] as! NSString;
                
                switch width{
                case 30:
                    vimeoUserDataMO_addUser.picture_30 = link as String
                case 75:
                    vimeoUserDataMO_addUser.picture_75 = link as String
                case 100:
                    vimeoUserDataMO_addUser.picture_100 = link as String
                case 300:
                    vimeoUserDataMO_addUser.picture_300 = link as String
                default:
                    return;
                }
            }
        }
        
        if let metadata = userData["metadata"] as? NSDictionary {
            if let connections = metadata["connections"] as? NSDictionary {
                if let albums = connections["albums"] as? NSDictionary {
                    let albumTotal = albums["total"] as? CGFloat
                    
                    self.vimeoData.albumTotal = albumTotal
                    self.vimeoData.updatePagination(inputTotal: albumTotal!, inputType: self.vimeoData.ALBUM)
                    
                    self.albumAmountLoaded = true
                }
                if let videos = connections["videos"] as? NSDictionary {
                    let videoTotal = videos["total"] as? CGFloat
                    self.vimeoData.videoTotal = videoTotal
                    self.vimeoData.updatePagination(inputTotal: videoTotal!, inputType: self.vimeoData.VIDEO)
                    
                    self.videoAmountLoaded = true
                }
            }
        }
        
        self.saveContext()
        
        // check Core Data for stored users
        checkCurrentUser(userData:userData)
    }
    
    func checkCurrentUser (userData:OAuth2JSON) {
        
        let currentResourceKey = userData["resource_key"] as? String
        
        let request = VimeoUserDataMO.createFetchRequest()
        
        do {
            let vimeoUserDataMO_Array = try self.container.viewContext.fetch(request)
            
            if (vimeoUserDataMO_Array.count != 0) {
                for vimeoUserDataMO in vimeoUserDataMO_Array {
                    if (currentResourceKey == vimeoUserDataMO.resource_key) {
                        vimeoUserDataMO.currentUser = true;
                    } else {
                        vimeoUserDataMO.currentUser = false;
                    }
                }
            }
            
        } catch {
            print("Fetch failed")
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
            } else {
                self.processUserData(userData:dict!)
                
                self.usrLoaded = true
                
                self.setPercentage()
                
                self.loadData()
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
            vimeoAlbumData.dataDic = albumArray[i] as! NSDictionary;
            
            let vimeoAlbumDataMO_addAlbum = VimeoAlbumDataMO(context: self.container.viewContext)
            
            vimeoAlbumDataMO_addAlbum.uri = vimeoAlbumData.dataDic["uri"] as? String
            vimeoAlbumDataMO_addAlbum.name = vimeoAlbumData.dataDic["name"] as? String
            vimeoAlbumDataMO_addAlbum.link = vimeoAlbumData.dataDic["link"] as? String
            vimeoAlbumDataMO_addAlbum.duration = vimeoAlbumData.dataDic["duration"] as! Float
            
            vimeoAlbumDataMO_addAlbum.created_time = df.date(from: vimeoAlbumData.dataDic["created_time"] as! String) as NSDate!
            vimeoAlbumDataMO_addAlbum.modified_time = df.date(from: vimeoAlbumData.dataDic["modified_time"] as! String) as NSDate!
            
            if let userdata = vimeoAlbumData.dataDic["user"] as? NSDictionary {
                let user_resource_key = userdata["resource_key"] as? String
                vimeoAlbumDataMO_addAlbum.user_resource_key = user_resource_key
            }
            
            self.saveContext()
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
    
    func checkResourceKeyExists (resourceKey:String) -> Bool {
        
        let request = VimeoVideoDataMO.createFetchRequest()
        let predicate = NSPredicate(format: "resource_key == %@", resourceKey)
        request.predicate = predicate
        //        request.fetchLimit = 1
        
        do{
            let results_Array = try self.container.viewContext.fetch(request)
            if (results_Array.count != 0) {
                return true
            } else {
                return false
            }
            
            
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    func checkDateForResourceIsNewer (resourceKey:String, newDate:NSDate) -> Bool {
        
        // Returns true if stored content is older than item linked to reourceKey
        
        let request = VimeoVideoDataMO.createFetchRequest()
        let predicate = NSPredicate(format: "resource_key == %@", resourceKey)
        request.predicate = predicate
        
        do{
            let results_Array = try self.container.viewContext.fetch(request)
            
            for i in 0 ..< results_Array.count
            {
                if (results_Array[i].modified_time == newDate){
                    return false
                } else {
                    return true
                }
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    func processvideoData (videoData:OAuth2JSON) {
		guard (videoData["data"] != nil) else {
			print("Processing Video Data Failed :: ")
			return
		}
		
        let videoArray = videoData["data"] as! NSArray
        
        for i in 0 ..< videoArray.count
        {
            // TODO: Remove all old Model references
            // TODO: check items exist > if changes > stop loading
            var vimeoVideoData = VimeoVideoData()
            vimeoVideoData.dataDic = videoArray[i] as! NSDictionary;
            
            let status : String!
            
            if(vimeoVideoData.dataDic["status"] is String) {
                status = vimeoVideoData.dataDic["status"] as! String
            } else {
                print("weird status error :: ", vimeoVideoData.dataDic["status"]!)
                status = ""
            }
			
			
			
			if (status == "uploading"){
				return
            } else {
                
                let vimeoVideoDataMO_addVideo = VimeoVideoDataMO(context: self.container.viewContext)
                
                let new_resource_key = vimeoVideoData.dataDic["resource_key"] as? String
                let new_date = df.date(from: vimeoVideoData.dataDic["modified_time"] as! String) as NSDate!
                
                if (checkResourceKeyExists(resourceKey: new_resource_key!)){
                    if (checkDateForResourceIsNewer(resourceKey: new_resource_key!, newDate:new_date!)){
                        vimeoVideoDataMO_addVideo.changed = true;
                        print ("found a change")
                    } else {
                        vimeoVideoDataMO_addVideo.changed = false
                    }
                }
                
                vimeoVideoDataMO_addVideo.resource_key = vimeoVideoData.dataDic["resource_key"] as? String
                
                if let userdata = vimeoVideoData.dataDic["user"] as? NSDictionary {
                    let user_resource_key = userdata["resource_key"] as? String
                    vimeoVideoDataMO_addVideo.user_resource_key = user_resource_key
                }
                
//                vimeoVideoDataMO_addVideo.changed
                
                vimeoVideoDataMO_addVideo.uri = vimeoVideoData.dataDic["uri"] as? String
                vimeoVideoDataMO_addVideo.name = vimeoVideoData.dataDic["name"] as? String
                vimeoVideoDataMO_addVideo.link = vimeoVideoData.dataDic["link"] as? String
                
                vimeoVideoDataMO_addVideo.duration = vimeoVideoData.dataDic["duration"] as! Float
                
                vimeoVideoDataMO_addVideo.width = vimeoVideoData.dataDic["width"] as! Float
                vimeoVideoDataMO_addVideo.height = vimeoVideoData.dataDic["height"] as! Float
                
                vimeoVideoDataMO_addVideo.created_time = df.date(from: vimeoVideoData.dataDic["created_time"] as! String) as NSDate!
                vimeoVideoDataMO_addVideo.modified_time = df.date(from: vimeoVideoData.dataDic["modified_time"] as! String) as NSDate!
                vimeoVideoDataMO_addVideo.release_time = df.date(from: vimeoVideoData.dataDic["release_time"] as! String) as NSDate!
                
                // Subs
                let tempMetadataDict = vimeoVideoData.dataDic["metadata"] as! NSDictionary
                let tempConnectionsDict = tempMetadataDict["connections"] as! NSDictionary
                let tempTexttracksDict = tempConnectionsDict["texttracks"] as! NSDictionary
                
                vimeoVideoDataMO_addVideo.texttracks_uri = tempTexttracksDict["uri"] as? String
                vimeoVideoDataMO_addVideo.texttracks_total = tempTexttracksDict["total"] as! Float
//                vimeoVideoDataMO_addVideo.subtitle_url = ""
                
                // Pictures
                let tempPictDict = vimeoVideoData.dataDic["pictures"] as! NSDictionary;
                
                let pictureSizeArray = tempPictDict["sizes"] as! NSArray;
                
                for j in 0 ..< pictureSizeArray.count
                {
                    let tempPictSizeDict = pictureSizeArray[j] as! NSDictionary;
                    let tempWidth = tempPictSizeDict["width"] as! NSNumber
                    let tempUrl = tempPictSizeDict["link"] as! NSString
                    
                    switch tempWidth {
                    case 100:
                        vimeoVideoDataMO_addVideo.thumb_url_100x75 = tempUrl as String
                    case 200:
                        vimeoVideoDataMO_addVideo.thumb_url_200x150 = tempUrl as String
                    case 295:
                        vimeoVideoDataMO_addVideo.thumb_url_295x166 = tempUrl as String
                    case 640:
                        vimeoVideoDataMO_addVideo.thumb_url_640x360 = tempUrl as String
                    case 960:
                        vimeoVideoDataMO_addVideo.thumb_url_960x540 = tempUrl as String
                    case 1280:
                        vimeoVideoDataMO_addVideo.thumb_url_1280x720 = tempUrl as String
                    default:
                        return
                    }
                }
                
                let tempStatsDict = vimeoVideoData.dataDic["stats"] as! NSDictionary
                vimeoVideoDataMO_addVideo.plays = tempStatsDict["plays"] as! Float
                
                // video files
                let tempFileArr = vimeoVideoData.dataDic["download"] as! NSArray
                
                for k in 0 ..< tempFileArr.count
                {
                    let tempFileDict = tempFileArr[k] as! NSDictionary;
                    let tempFileQuality = tempFileDict["quality"] as! String
                    let tempFileWidth = tempFileDict["width"] as! Float
                    let tempFileUrl = tempFileDict["link"] as! String
                    let tempFileCreated = df.date(from: tempFileDict["created_time"] as! String) as NSDate!
                    let tempFileExpires = df.date(from: tempFileDict["expires"] as! String) as NSDate!
                    
                    if (tempFileWidth == vimeoVideoDataMO_addVideo.width) {
                        if (tempFileQuality == "hd") {
                            vimeoVideoDataMO_addVideo.video_src_url_HD = tempFileUrl
                            vimeoVideoDataMO_addVideo.video_src_url_HD_created = tempFileCreated
                            vimeoVideoDataMO_addVideo.video_src_url_HD_expires = tempFileExpires
                        }
                        if (tempFileQuality == "source") {
                            vimeoVideoDataMO_addVideo.video_src_url_Source = tempFileUrl
                            vimeoVideoDataMO_addVideo.video_src_url_Source_created = tempFileCreated
                            vimeoVideoDataMO_addVideo.video_src_url_Source_expires = tempFileExpires
                        }
                    }
                }
                
                self.saveContext()
                
                //////////
            
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
				
				vimeoVideoData.texttracks_uri = tempTexttracksDict["uri"] as! NSString
				vimeoVideoData.texttracks_total = tempTexttracksDict["total"] as! NSNumber
				
//				print(vimeoVideoData.texttracks_uri)
				
				
				// Pictures
				
				for l in 0 ..< pictureSizeArray.count
				{
					let tempPictSizeDict2 = pictureSizeArray[l] as! NSDictionary;
					let tempWidth3 = tempPictSizeDict2["width"] as! NSNumber
					let tempUrl3 = tempPictSizeDict2["link"] as! NSString
					
					switch tempWidth3 {
					case 100:
						vimeoVideoData.thumb_url_100x75 = tempUrl3
					case 200:
						vimeoVideoData.thumb_url_200x150 = tempUrl3
					case 295:
						vimeoVideoData.thumb_url_295x166 = tempUrl3
					case 640:
						vimeoVideoData.thumb_url_640x360 = tempUrl3
					case 960:
						vimeoVideoData.thumb_url_960x540 = tempUrl3
					case 1280:
						vimeoVideoData.thumb_url_1280x720 = tempUrl3
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
        
        percentagePerCall = 0
        callStep = 0
        
        usrLoaded = false
        albumsLoaded = false
        videosLoaded = false
        checkedLoadAmount = false
        
        albumAmountLoaded = false
        videoAmountLoaded = false
        
        albumPagination = 0
        videoPagination = 0
        
        
        
        loadData()
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
