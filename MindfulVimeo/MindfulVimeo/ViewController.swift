//
//  ViewController.swift
//  MindfulVimeo
//
//  Created by Rob Slegtenhorst on 29/05/2018.
//  Copyright © 2018 Rob Slegtenhorst. All rights reserved.
//

//TODO :: dropdown with current vimeo albums
//TODO :: include logo videos
//TODO :: progress bar
//TODO :: create  flow. select upload, csv or posterframe option > select videos to upload > select college(s) > upload to new album(s) (auto create folders based on course?), or existing > uplaod switch > local render location > show progress during upload (with rate limit warning) > show link to folder? > secondary flow with poster frame? poss with time entry
//TODO :: select multiple upload folders and college names


import Cocoa

struct AllVimeoAlbums: Decodable {
	let total: Int
	let page: Int
	let per_page: Int
	let albums: [VimeoAlbum]
	
	enum CodingKeys : String, CodingKey {
		case total
		case page
		case per_page
		case albums = "data"
	}
}

struct VimeoAlbum: Decodable {
	let uri: String
	let name: String
	let link: URL
}

struct VimeoHeaders: Decodable {
	let xRatelimitLimit: String
	let xRatelimitRemaining: String
	
	enum CodingKeys : String, CodingKey {
		case xRatelimitLimit = "x-ratelimit-limit"
		case xRatelimitRemaining = "x-ratelimit-remaining"
	}
}

class ViewController: NSViewController {
	
	let nodePath = Bundle.main.path(forResource: "node", ofType: "");
    let ffprobePath = Bundle.main.path(forResource: "ffprobe", ofType: "");
    let ffmpegPath = Bundle.main.path(forResource: "ffmpeg", ofType: "");
    
    let testvid = Bundle.main.path(forResource: "Logos_AfterCodecs/AbingdonWitney_CombinedLogo_v002", ofType: "mp4");
    
    
    
//    let exampleNode = Bundle.main.path(forResource: "mindful", ofType: "js", inDirectory: "vimeo.js-2.0.2/example");
    let exampleNode = Bundle.main.path(forResource: "me_GetAlbums", ofType: "js", inDirectory: "NodeFiles/VimeoFiles");
	
	@IBOutlet weak var tempTextField: NSTextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
    @IBAction func ffprobe(_ sender: NSButton) {
        
        //        let arguments: [String] = ["-print_format", "json", "-show_format", "-show_streams", testvid!]
        let encodeArgs = ["-y","-hide_banner", "-v", "quiet", "-stats", "-i", testvid, "-i", testvid, "-filter_complex", "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]", "-map", "[outv]", "-map", "[outa]", "/Users/robslegtenhorst/test.mp4"]
        betterShell(launchPath: ffmpegPath!, arguments: encodeArgs as! [String])
        
//        betterShell(launchPath: "/bin/sh", arguments: ["-c", ffmpegPath!])
        
//        betterShell(launchPath: "/bin/sh", arguments: ["-c", "echo 1 ; sleep 1 ; echo 2 ; sleep 1 ; echo 3 ; sleep 1 ; echo 4"])
        
        
//        let arguments: [String] = ["-print_format", "json", "-show_format", "-show_streams", testvid!]
//        let task = Process.launchedProcess(launchPath: ffmpegPath!, arguments: encodeArgs as! [String])
//        task.waitUntilExit();
//        let albumData : Data = albumDataString.data(using: .utf8)!
        
//        print(task)
        
//        guard let allVimeoAlbums = try? JSONDecoder().decode(AllVimeoAlbums.self, from: albumData) else {
//            print("Error: Couldn't decode data into Blog")
//            return
//        }
        
//        print("album 1 title: \(allVimeoAlbums.albums[0].name)")
    }
    
	@IBAction func connectBtn(_ sender: NSButton) {
		let arguments: [String] = [exampleNode!]
        let albumDataString = shell(launchPath: nodePath!, arguments: arguments)
		let albumData : Data = albumDataString.data(using: .utf8)!
		
        print(albumDataString)
		
		guard let allVimeoAlbums = try? JSONDecoder().decode(AllVimeoAlbums.self, from: albumData) else {
			print("Error: Couldn't decode data into Blog")
			return
		}
		
		print("album 1 title: \(allVimeoAlbums.albums[0].name)")
		
//		tempTextField.stringValue = shell(launchPath: nodePath!, arguments: arguments)
	}
	
	func shell(launchPath: String, arguments: [String]) -> String
	{
		let task = Process()
		task.launchPath = launchPath
		task.arguments = arguments
		
        let pipe = Pipe()
        task.standardOutput = pipe
        let errpipe = Pipe()
        task.standardError = errpipe
		task.launch()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: String.Encoding.utf8)!
        
        task.waitUntilExit()
        
		if output.count > 0 {
			//remove newline character.
			let lastIndex = output.index(before: output.endIndex)
			return String(output[output.startIndex ..< lastIndex])
		}
        
        return output
	}
    
    func betterShell(launchPath: String, arguments: [String]) -> Void
    {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardError = pipe
        let outHandle = pipe.fileHandleForReading
        outHandle.waitForDataInBackgroundAndNotify()
        
        var obs1 : NSObjectProtocol!
        obs1 = NotificationCenter.default.addObserver(forName: NSNotification.Name.NSFileHandleDataAvailable,
                                                      object: outHandle, queue: nil) {  notification -> Void in
                                                        let data = outHandle.availableData
                                                        if data.count > 0 {
                                                            if let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                                                                let currentframeArray = str.condensedWhitespace.components(separatedBy: " ")
                                                                print("got output: \(currentframeArray[1])")
                                                            }
                                                            outHandle.waitForDataInBackgroundAndNotify()
                                                        } else {
                                                            print("EOF on stdout from process")
                                                            NotificationCenter.default.removeObserver(obs1)
                                                        }
        }
        
        var obs2 : NSObjectProtocol!
        obs2 = NotificationCenter.default.addObserver(forName: Process.didTerminateNotification,
                                                      object: task, queue: nil) { notification -> Void in
                                                        print("terminated")
                                                        NotificationCenter.default.removeObserver(obs2)
        }
        task.launch()
    }

}

