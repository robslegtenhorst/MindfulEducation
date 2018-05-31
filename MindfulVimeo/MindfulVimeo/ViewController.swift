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
	let exampleNode = Bundle.main.path(forResource: "mindful", ofType: "js", inDirectory: "vimeo.js-2.0.2/example");
	
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
		task.launch()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: String.Encoding.utf8)!
		if output.count > 0 {
			//remove newline character.
			let lastIndex = output.index(before: output.endIndex)
			return String(output[output.startIndex ..< lastIndex])
		}
		return output
	}

}

