//
//  VideoDetailController.swift
//  ME_VimeoApp
//
//  Created by Rob Slegtenhorst on 19/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import Cocoa
import OAuth2
import Alamofire

class VideoDetailController: NSViewController {
	
	var vimeoVideoData : VimeoVideoDataMO!
	var vimeoVideoindex : Int!
	var loader : VimeoLoader!
	
	@IBOutlet weak var imgBtn: NSButton!
	@IBOutlet weak var imgBtnCell: NSButtonCell!
	
	@IBOutlet weak var nameField: NSTextField!
	
	@IBOutlet weak var urlField: NSTextField!
	@IBOutlet weak var durationField: NSTextField!
	@IBOutlet weak var widthField: NSTextField!
	@IBOutlet weak var heightField: NSTextField!
	@IBOutlet weak var createdField: NSTextField!
	@IBOutlet weak var modifiedField: NSTextField!
	@IBOutlet weak var releasedField: NSTextField!
	@IBOutlet weak var playsField: NSTextField!
	
	@IBOutlet weak var getSubs: NSButton!
	
	@IBOutlet weak var getHDBtn: NSButton!
	@IBOutlet weak var getSrcBtn: NSButton!
	
	override func viewDidAppear() {
		super.viewDidAppear()
		reloadData(data: vimeoVideoData)
		print("view appeared")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nameField.resignFirstResponder()
        
		print("view loaded")
	}
	
	func reloadData (data: VimeoVideoDataMO) {
		imgBtnCell.image = NSImage()
		nameField.placeholderString = data.name!
		
		urlField.stringValue = data.link!
		durationField.stringValue = data.duration.description as String
		widthField.stringValue = data.width.description as String
		heightField.stringValue = data.height.description as String
		createdField.stringValue = (data.created_time?.description)!
		modifiedField.stringValue = (data.modified_time?.description)!
		releasedField.stringValue = (data.release_time?.description)!
		playsField.stringValue = data.plays.description as String
		
//		print ("texttracks_total :: " + data.texttracks_total.description)
//		print ("subtitle_url :: " + (data.subtitle_url?.description)!)
		
		if(data.texttracks_total != 0 && data.subtitle_url != "" && data.subtitle_url != nil) {
			getSubs.isEnabled = true
			getSubs.isHidden = false
			getSubs.title = "Download"
		} else if(data.texttracks_total != 0 && data.subtitle_url == "") {
			getSubs.isEnabled = true
			getSubs.isHidden = false
			getSubs.title = "Get"
		} else if(data.texttracks_total == 0) {
			print("No Sub Found")
			getSubs.isEnabled = false
			getSubs.title = "No Subs"
		}
		
		// TODO: set preloader for large images
		let imageURL = URL(string: data.thumb_url_1280x720!)
		imgBtn.image = NSImage(byReferencing: imageURL!)
	}
	
	@IBAction func getSubsReq(_ sender: NSButton) {
        
        //TODO Issues showing subs, possibly due to missing urls
        
        if (getSubs.title == "Get")
        {
            loader.requestSub(uri: vimeoVideoData.texttracks_uri! as NSString) { dict, error in
                if let error = error {
                    switch error {
                    case OAuth2Error.requestCancelled:
                        print("Cancelled. Try Again.")
                    default:
                        print("Failed. Try Again.")
                        self.show(error)
                    }
                }
                else {
                    
                    self.processSubs(subData:dict!)
                }
            }
        } else {
//            print("download subs :: "+(vimeoVideoData.subtitle_url!))
			
			// TODO: let user decide where to save file
			// TODO: "open file"
			
			let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
			Alamofire.download(self.vimeoVideoData.subtitle_url!, to: destination).response { response in
				print(response)
			}
        }
	}
	
	func processSubs (subData:OAuth2JSON) {
		guard (subData["data"] != nil) else {
			print("Processing Sub Data Failed :: ")
			return
		}
		
		let subArray = subData["data"] as! NSArray
		
		let dataDic = subArray[0] as! NSDictionary;
		
		let subtitle_url = dataDic["link"] as! NSString
        
        self.vimeoVideoData.subtitle_url = subtitle_url as String
		
		getSubs.isEnabled = true
		getSubs.isHidden = false
		getSubs.title = "Download"
		
//		subsField.stringValue = data.subtitle_url as String
	}
	
	@IBAction func getSrc(_ sender: NSButton) {
	}
	
	@IBAction func getHD(_ sender: NSButton) {
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
