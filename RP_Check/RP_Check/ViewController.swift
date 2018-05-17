//
//  ViewController.swift
//  RP_Check
//
//  Created by Rob Slegtenhorst on 15/05/2018.
//  Copyright © 2018 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import Witness

public enum FileOrder: String {
	case Priority
	case Name
	case Status
	case Submitted
}

class FrameRange {
	var Value = "";
	var startFrame:Int = 0
	var endFrame:Int = 0
	var currentFrame:Int = 0
}

class NetjobObj: NSObject {
	
	var NetJobID: String!
	var TimeElapsedText: String!
	var Priority: String!
	var CreationDateText: String!
	var Renderer: String!
	var SubmitterName: String!
	var Name: String!
	var FinishDateText: String!
	var StatusText: String!
	
	var RenderSet: String!
	
	var CustomFields: String!
	
	var FrameRange: FrameRange!
	
	
	override init() {
		//
	}
	
	override var description: String {
		return "\(NetJobID) \(Name)"
	}
}


class ViewController: NSViewController, XMLParserDelegate {
	
	//TODO :: add config screen with server ip, user name and password
	//DONE :: show frame numbers
	//TODO :: show elapsed time (in real time)
	//TODO :: show log file
	//DONE :: read log and show current percentage done
	//TODO :: fix sorting
	//TODO :: add in file change events

	@IBOutlet weak var ComputerName: NSTextField!
	@IBOutlet weak var LastJobTimeText: NSTextField!
	@IBOutlet weak var ElapsedTimeText: NSTextField!
	
	@IBOutlet weak var NetJobID: NSTextField!
	@IBOutlet weak var TimeElapsedText: NSTextField!
	@IBOutlet weak var Priority: NSTextField!
	@IBOutlet weak var CreationDateText: NSTextField!
	@IBOutlet weak var Renderer: NSTextField!
	@IBOutlet weak var SubmitterName: NSTextField!
	@IBOutlet weak var Name: NSTextField!
	@IBOutlet weak var FinishDateText: NSTextField!
	@IBOutlet weak var StatusText: NSTextField!
	
	var witness: Witness?
	
	
	struct Netjob {
		var NetJobID = " "
		var TimeElapsedText = " "
		var Priority = " "
		var CreationDateText = ""
		var Renderer = " "
		var SubmitterName = " "
		var Name = " "
		var FinishDateText = " "
		var StatusText = " "
		
		var RenderSet = " "
		var FrameRange = " "
		var CustomFields = " "
	}
	
	struct Client {
		var Scheduled = " "
		var Frames = " "
		var AutoWOL = " "
		var ComputerName = " "
		var UseStdPort = " "
		var MacAddress = " "
		var Slice = " "
		var OS = " "
		var LastJobTimeText = " "
		var Priority = " "
		var PoolList = " "
		var MemoryTotal = " "
		var ElapsedTimeText = " "
		var CPUCount = " "
		var ScheduleField = " "
		var Uuid = " "
		var CurrentJob = " "
		var Paused = " "
		var MemoryFree = " "
		var Build = " "
		var Alias = " "
		var Notes = " "
		var LastJobTime = " "
		var CPUUsage = " "
		var Status = " "
		var ScheduleName = " "
		var ElapsedTime = " "
		var Scene = " "
		var Address = " "
		var StatusText = " "
		var Port = " "
	}
	
	@IBOutlet weak var tableView: NSTableView!
	
	var sortOrder = ""
	var sortAscending = true
	
	let filePath = Bundle.main.path(forResource: "rprccmd", ofType: "");
	
	var returnedXML : XMLDocument!;
	
	var clientArray: [Client] = []
	var netjobArray: [NetjobObj] = []
	
	var currentSelectedItem: [NetjobObj] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.target = self
		tableView.doubleAction = #selector(tableViewDoubleClick(_:))
		
		
		
		// 1
		let descriptorPriority = NSSortDescriptor(key: "NetJobID", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
		let descriptorName = NSSortDescriptor(key: FileOrder.Name.rawValue, ascending: true)
		let descriptorStatus = NSSortDescriptor(key: FileOrder.Status.rawValue, ascending: true)
		let descriptorSubmitted = NSSortDescriptor(key: FileOrder.Submitted.rawValue, ascending: true)
		
		// 2
		tableView.tableColumns[0].sortDescriptorPrototype = descriptorPriority
		tableView.tableColumns[1].sortDescriptorPrototype = descriptorName
		tableView.tableColumns[2].sortDescriptorPrototype = descriptorStatus
		tableView.tableColumns[3].sortDescriptorPrototype = descriptorSubmitted
		
		runRefresh()

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	@IBAction func RefreshBtn(_ sender: NSButton) {
		runRefresh()
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
	
	func bash(command: String, arguments: [String]) -> String {
		let whichPathForCommand = shell(launchPath: "/bin/bash", arguments: [ "-l", "-c", "which \(command)" ])
		return shell(launchPath: whichPathForCommand, arguments: arguments)
	}
	
	@IBAction func ClearFinsihedItems(_ sender: NSMenuItem) {
		let answer = dialogOKCancel(question: "Please confirm", text: "Would you like to clear all finsihed renders?")
		
		if (netjobArray.count > 0 && answer) {
			var arguments: [String] = ["-compact"]
			for netjob in netjobArray {
				if(netjob.StatusText == "Done"){
					arguments.append("-control_nj")
					arguments.append("remove:"+netjob.NetJobID)
				}
			}
			print(shell(launchPath: filePath!, arguments: arguments))
			runRefresh()
			print(arguments)
		}
	}
	
	@IBAction func DeleteBtn(_ sender: NSButton) {
		
		let answer = dialogOKCancel(question: "Please confirm", text: "Would you like to clear all finsihed renders?")
		
		if (netjobArray.count > 0 && answer) {
			var arguments: [String] = ["-compact"]
			for netjob in currentSelectedItem {
				if(netjob.StatusText == "Done"){
					arguments.append("-control_nj")
					arguments.append("remove:"+netjob.NetJobID)
				} else if(netjob.StatusText == "Canceled"){
					arguments.append("-control_nj")
					arguments.append("remove:"+netjob.NetJobID)
				} else {
					let answerNotDone = dialogOKCancel(question: "Please confirm", text: netjob.Name+" is not completed yet, would you still like to remove this render?")
					if (answerNotDone) {
						arguments.append("-control_nj")
						arguments.append("remove:"+netjob.NetJobID)
					}
				}
			}
			print(shell(launchPath: filePath!, arguments: arguments))
			runRefresh()
			print(arguments)
		}
	}
	
	@IBAction func ClearItems(_ sender: NSMenuItem) {
		let answer = dialogOKCancel(question: "Please confirm", text: "Would you like to clear all finsihed renders?")
		
		if (netjobArray.count > 0 && answer) {
			var arguments: [String] = ["-compact"]
			for netjob in currentSelectedItem {
				if(netjob.StatusText == "Done"){
					arguments.append("-control_nj")
					arguments.append("remove:"+netjob.NetJobID)
				} else if(netjob.StatusText == "Canceled"){
					arguments.append("-control_nj")
					arguments.append("remove:"+netjob.NetJobID)
				} else {
					let answerNotDone = dialogOKCancel(question: "Please confirm", text: netjob.Name+" is not completed yet, would you still like to remove this render?")
					if (answerNotDone) {
						arguments.append("-control_nj")
						arguments.append("remove:"+netjob.NetJobID)
					}
				}
			}
			print(shell(launchPath: filePath!, arguments: arguments))
			runRefresh()
			print(arguments)
		}
	}
	@IBAction func logTest(_ sender: NSMenuItem) {
		currentSelectedItem.removeAll()
		currentSelectedItem.append( self.netjobArray[self.tableView.clickedRow] as NetjobObj)
		
		getLatestFrame()
	}
	
	func getLatestFrame() {
		
		if (currentSelectedItem.count > 1)
		{
			dialogOK(question: "Error", text: "Please only select a single item")
		} else {
			
			for netjob in currentSelectedItem {
				
				let oldDate:[Substring] = netjob.CreationDateText.split(separator: "/")
				let yearString:String = String(oldDate[2])
				let year:[Substring] = yearString.split(separator: " ")
				
				let newDate:String = year[0] + "-" + oldDate[1] + "-"  + oldDate[0]
			
				let filePath = "/Volumes/mindful_rack/_WIN_RENDER/RP_Log/"+newDate+"."+netjob.NetJobID+".1-01.output.log"
				let fileURL:URL = URL(fileURLWithPath: filePath)
				
				//TODO add in file change events
				
				if ( netjob.StatusText == "Rendering")
				{
					self.witness = Witness(paths: [filePath], flags: .FileEvents, latency: 0.3) { events in
						print("file system events received: \(events)")
					}
				}
				
//				print("netjob date :: "+netjob.CreationDateText)
				
				//reading
				do {
					let text2:String = try String(contentsOf: fileURL, encoding: .utf8)
					
					let logProgress:[String] = text2.components(separatedBy: "PROGRESS:  ")
					
					var currentProgress: String!
					var currentFrames: [String]!
					var currentFrame: Int!
					
					if ( netjob.StatusText == "Done")
					{
						currentProgress = logProgress[logProgress.count-3]
					} else {
						currentProgress = logProgress[logProgress.count-1]
					}
					
					currentFrames = currentProgress.components(separatedBy: " (")
					currentFrame = Int(String(currentFrames[1]).components(separatedBy: ")")[0])
					
//					print(currentFrame)
					
				}
				catch {
					print(error)
				}
				
			}
			
		}
		
	}
	
	func getAllLatestFrames(netjobObj: NetjobObj, startFrame : Int, endFrame : Int) -> Int {
		print(netjobObj.StatusText)
		if(netjobObj.StatusText == "Rendering")
		{
			let oldDate:[Substring] = netjobObj.CreationDateText.split(separator: "/")
			let yearString:String = String(oldDate[2])
			let year:[Substring] = yearString.split(separator: " ")
			
			let newDate:String = year[0] + "-" + oldDate[1] + "-"  + oldDate[0]
			
			let filePath = "/Volumes/mindful_rack/_WIN_RENDER/RP_Log/"+newDate+"."+netjobObj.NetJobID+".1-01.output.log"
			let fileURL:URL = URL(fileURLWithPath: filePath)
			
			print("netjob date :: "+netjobObj.CreationDateText)
			
			//reading
			do {
				let text2:String = try String(contentsOf: fileURL, encoding: .utf8)
				
				let logProgress:[String] = text2.components(separatedBy: "PROGRESS:  ")
				
				var currentProgress: String!
				var currentFrames: [String]!
				var currentFrame: Int!
				
				if ( netjobObj.StatusText == "Done")
				{
					currentProgress = logProgress[logProgress.count-3]
				} else {
					currentProgress = logProgress[logProgress.count-1]
				}
				
				currentFrames = currentProgress.components(separatedBy: " (")
				currentFrame = Int(String(currentFrames[1]).components(separatedBy: ")")[0])
				
				return(currentFrame)
				
			}
			catch {
				print(error)
				return(startFrame)
			}
		} else if(netjobObj.StatusText == "Done")
		{
			return(endFrame)
		} else if(netjobObj.StatusText == "Rendering")
		{
			return(startFrame)
		}
		
		return(startFrame)
		
	}
	
	func runRefresh(){
		if (clientArray.count > 0)
		{
			clientArray.removeAll()
		}
		if (netjobArray.count > 0)
		{
			netjobArray.removeAll()
		}
		
		let clientDetails = runCommand(cmd:filePath!, args: "-compact","-query","client:MINDFULRENDER").output
		let netJobDetails = runCommand(cmd:filePath!, args: "-compact","-query","netjob:*").output
		
		if let data = clientDetails.data(using: .utf16) { // Get the NSData
			let xmlParser = XMLParser(data: data)
			let delegate = ClientDelegate() // This is your own delegate - see below
			xmlParser.delegate = delegate
			if xmlParser.parse() {
				print("Result \(delegate.clientArray.count)")
				clientArray = delegate.clientArray
				ComputerName.stringValue = delegate.clientArray[0].ComputerName;
				LastJobTimeText.stringValue = delegate.clientArray[0].LastJobTimeText;
				ElapsedTimeText.stringValue = delegate.clientArray[0].ElapsedTimeText;
			}
		}
		if let data2 = netJobDetails.data(using: .utf16) { // Get the NSData
			let xmlParser = XMLParser(data: data2)
			let delegate2 = NetjobDelegate()
			xmlParser.delegate = delegate2
			if xmlParser.parse() {
				//print("Result \(delegate2.netjobArray[0].RenderSet)")
				netjobArray = delegate2.netjobArray
				
				//parse renderset data
				for netjobObj in netjobArray {
					let brokenXML = netjobObj.RenderSet.components(separatedBy: "</RenderSet>")
					let fixedXML = brokenXML[0]+"</RenderSet>"
					netjobObj.RenderSet = fixedXML
					
//					print("test::"+netjobObj.RenderSet)
					
					let xmlData = netjobObj.RenderSet.data(using: String.Encoding.utf8)!
					let parser = XMLParser(data: xmlData)
					let frameDelegate = FrameRangeXMLParser()
					parser.delegate = frameDelegate
					if parser.parse() {
//						print("2::"+netjobObj.StatusText)
						netjobObj.FrameRange = frameDelegate.items[0]
						
						var frameRange = netjobObj.FrameRange.Value.components(separatedBy: "-")
						netjobObj.FrameRange.startFrame = Int(frameRange[0])!
						netjobObj.FrameRange.endFrame = Int(frameRange[1])!
						netjobObj.FrameRange.currentFrame = getAllLatestFrames(netjobObj: netjobObj, startFrame: netjobObj.FrameRange.startFrame, endFrame: netjobObj.FrameRange.endFrame)
						
//						print("Result \(netjobObj.FrameRange.currentFrame)")
					} else {
						print("error?")
					}
					
				}
				
				
			}
		}
		
		tableView.reloadData()
	}
	
	class ClientDelegate: NSObject, XMLParserDelegate {
		// Simple state machine to capture fields and add completed Person to array
		var clientArray: [Client] = []
		
		enum State { case none, Scheduled, Frames, AutoWOL, ComputerName, UseStdPort, MacAddress, Slice, OS, LastJobTimeText, Priority, PoolList, MemoryTotal, ElapsedTimeText, CPUCount, ScheduleField, Uuid, CurrentJob, Paused, MemoryFree, Build, Alias, Notes, LastJobTime, CPUUsage, Status, ScheduleName, ElapsedTime, Scene, Address, StatusText, Port, NetJobID, TimeElapsedText, CreationDateText,Renderer, SubmitterName, Name, FinishDateText }
		var state: State = .none
		var newClient: Client? = nil
		
		func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
			switch elementName {
			case "Client" :
				self.newClient = Client()
				self.state = .none
			case "Scheduled":
				self.state = .Scheduled
			case "Frames":
				self.state = .Frames
			case "AutoWOL":
				self.state = .AutoWOL
			case "ComputerName":
				self.state = .ComputerName
			case "UseStdPort":
				self.state = .UseStdPort
			case "MacAddress":
				self.state = .MacAddress
			case "Slice":
				self.state = .Slice
			case "OS":
				self.state = .OS
			case "LastJobTimeText":
				self.state = .LastJobTimeText
			case "Priority":
				self.state = .Priority
			case "PoolList":
				self.state = .PoolList
			case "MemoryTotal":
				self.state = .MemoryTotal
			case "ElapsedTimeText":
				self.state = .ElapsedTimeText
			case "CPUCount":
				self.state = .CPUCount
			case "ScheduleField":
				self.state = .ScheduleField
			case "Uuid":
				self.state = .Uuid
			case "CurrentJob":
				self.state = .CurrentJob
			case "Paused":
				self.state = .Paused
			case "MemoryFree":
				self.state = .MemoryFree
			case "Build":
				self.state = .Build
			case "Alias":
				self.state = .Alias
			case "Notes":
				self.state = .Notes
			case "LastJobTime":
				self.state = .LastJobTime
			case "CPUUsage":
				self.state = .CPUUsage
			case "Status":
				self.state = .Status
			case "ScheduleName":
				self.state = .ScheduleName
			case "ElapsedTime":
				self.state = .ElapsedTime
			case "Scene":
				self.state = .Scene
			case "Address":
				self.state = .Address
			case "StatusText":
				self.state = .StatusText
			case "Port":
				self.state = .Port
			default:
				self.state = .none
			}
		}
		func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
			if let newClient = self.newClient, elementName == "Client" {
				self.clientArray.append(newClient)
				self.newClient = nil
			}
			self.state = .none
		}
		
		func parser(_ parser: XMLParser, foundCharacters string: String) {
			guard let _ = self.newClient else { return }
			switch self.state {
			case .Scheduled:
				self.newClient!.Scheduled = string
			case .Frames:
				self.newClient!.Frames = string
			case .AutoWOL:
				self.newClient!.AutoWOL = string
			case .ComputerName:
				self.newClient!.ComputerName = string
			case .UseStdPort:
				self.newClient!.UseStdPort = string
			case .MacAddress:
				self.newClient!.MacAddress = string
			case .Slice:
				self.newClient!.Slice = string
			case .OS:
				self.newClient!.OS = string
			case .LastJobTimeText:
				self.newClient!.LastJobTimeText = string
			case .Priority:
				self.newClient!.Priority = string
			case .PoolList:
				self.newClient!.PoolList = string
			case .MemoryTotal:
				self.newClient!.MemoryTotal = string
			case .ElapsedTimeText:
				self.newClient!.ElapsedTimeText = string
			case .CPUCount:
				self.newClient!.CPUCount = string
			case .ScheduleField:
				self.newClient!.ScheduleField = string
			case .Uuid:
				self.newClient!.Uuid = string
			case .CurrentJob:
				self.newClient!.CurrentJob = string
			case .Paused:
				self.newClient!.Paused = string
			case .MemoryFree:
				self.newClient!.MemoryFree = string
			case .Build:
				self.newClient!.Build = string
			case .Alias:
				self.newClient!.Alias = string
			case .Notes:
				self.newClient!.Notes = string
			case .LastJobTime:
				self.newClient!.LastJobTime = string
			case .CPUUsage:
				self.newClient!.CPUUsage = string
			case .Status:
				self.newClient!.Status = string
			case .ScheduleName:
				self.newClient!.ScheduleName = string
			case .ElapsedTime:
				self.newClient!.ElapsedTime = string
			case .Scene:
				self.newClient!.Scene = string
			case .Address:
				self.newClient!.Address = string
			case .StatusText:
				self.newClient!.StatusText = string
			case .Port:
				self.newClient!.Port = string
			default:
				break
			}
		}
		
		func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
		}
	}
	
	class FrameRangeXMLParser: NSObject, XMLParserDelegate {
		var items = [FrameRange]();
		var item = FrameRange();
		var foundCharacters = "";
		
		func parser(_ parser: XMLParser, foundCharacters string: String) {
			self.foundCharacters += string;
		}
		
		func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
			if elementName == "Value" {
				self.item.Value = self.foundCharacters;
			}
			if elementName == "frames" {
				let tempItem = FrameRange();
//				print("self.foundCharacters::"+self.foundCharacters)
//				print("self.item.Value::"+self.item.Value)
				tempItem.Value = self.item.Value;
				self.items.append(tempItem);
			}
			self.foundCharacters = ""
		}
		
		func parserDidEndDocument(_ parser: XMLParser) {
			//
		}
	}

	
	class NetjobDelegate: NSObject, XMLParserDelegate {
		// Simple state machine to capture fields and add completed Person to array
		var netjobArray: [NetjobObj] = []
		enum State { case none, Priority, StatusText, NetJobID, TimeElapsedText, CreationDateText,Renderer, SubmitterName, Name, FinishDateText, RenderSet, CustomFields }
		var state: State = .none
		var newNetjob: NetjobObj? = nil
		
		func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
			switch elementName {
			case "NetJob" :
				self.newNetjob = NetjobObj()
				self.state = .none
			case "Priority":
				self.state = .Priority
			case "StatusText":
				self.state = .StatusText
			case "NetJobID" :
				self.state = .NetJobID
			case "TimeElapsedText" :
				self.state = .TimeElapsedText
			case "CreationDateText" :
				self.state = .CreationDateText
			case "Renderer" :
				self.state = .Renderer
			case "SubmitterName" :
				self.state = .SubmitterName
			case "Name" :
				self.state = .Name
			case "FinishDateText" :
				self.state = .FinishDateText
			case "Value" :
				self.state = .RenderSet
			case "CustomFields" :
				self.state = .CustomFields
			default:
				self.state = .none
			}
		}
		func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
			if let newNetjob = self.newNetjob, elementName == "NetJob" {
				self.netjobArray.append(newNetjob)
				self.newNetjob = nil
			}
			self.state = .none
		}
		
		func parser(_ parser: XMLParser, foundCharacters string: String) {
			guard let _ = self.newNetjob else { return }
			switch self.state {
			case .Priority:
				self.newNetjob!.Priority = string
			case .StatusText:
				self.newNetjob!.StatusText = string
			case .NetJobID :
				self.newNetjob!.NetJobID = string
			case .TimeElapsedText :
				self.newNetjob!.TimeElapsedText = string
			case .CreationDateText :
				self.newNetjob!.CreationDateText = string
			case .Renderer :
				self.newNetjob!.Renderer = string
			case .SubmitterName :
				self.newNetjob!.SubmitterName = string
			case .Name :
				self.newNetjob!.Name = string
			case .FinishDateText :
				self.newNetjob!.FinishDateText = string
			case .RenderSet :
//				print(string)
				if (string != "\\t" && string != "\\t\\t" && string != "\\t\\t\\t")
				{
					//print(string)
					if (self.newNetjob!.RenderSet != nil)
					{
						self.newNetjob!.RenderSet.append(string)
					} else {
						self.newNetjob!.RenderSet = string
					}
				}
			case .CustomFields :
				self.newNetjob!.CustomFields = string
			default:
				break
			}
		}
		
		func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
		}
	}
	
	func runCommand(cmd : String, args : String...) -> (output: String, error: [String], exitCode: Int32) {
		
		var output : String = ""
		var error : [String] = []
		
		let task = Process()
		task.launchPath = cmd
		task.arguments = args
		
		let outpipe = Pipe()
		task.standardOutput = outpipe
		let errpipe = Pipe()
		task.standardError = errpipe
		
		task.launch()
		
		let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
		if var string = String(data: outdata, encoding: .utf8) {
			string = string.trimmingCharacters(in: .newlines)
			//output = string.components(separatedBy: "\n")
			output = string
		}
		
		let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
		if var string = String(data: errdata, encoding: .utf8) {
			string = string.trimmingCharacters(in: .newlines)
			error = string.components(separatedBy: "\n")
		}
		
		task.waitUntilExit()
		let status = task.terminationStatus
		
		return (output, error, status)
	}
	
	func dialogOKCancel(question: String, text: String) -> Bool {
		let alert = NSAlert()
		alert.messageText = question
		alert.informativeText = text
		alert.alertStyle = .warning
		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")
		return alert.runModal() == .alertFirstButtonReturn
	}
	
	func dialogOK(question: String, text: String) -> Bool {
		let alert = NSAlert()
		alert.messageText = question
		alert.informativeText = text
		alert.alertStyle = .warning
		alert.addButton(withTitle: "OK")
		return alert.runModal() == .alertFirstButtonReturn
	}
	
}
extension ViewController: NSTableViewDataSource {
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		//print(self.netjobArray.count)
		return self.netjobArray.count ?? 0
	}
	
}

extension ViewController: NSTableViewDelegate {
	
	fileprivate enum CellIdentifiers {
		static let PriorityCell = "PriorityCellID"
		static let NameCell = "NameCellID"
		static let FrameStatusCell = "FrameStatusCellID"
		static let StatusCell = "StatusCellID"
		static let SubmittedCell = "SubmittedCellID"
	}
	
	func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
//		// 1
//		guard let sortDescriptor = tableView.sortDescriptors.first else {
//			return
//		}
//		if let order = FileOrder(rawValue: sortDescriptor.key!) {
//			// 2
//			sortOrder = order.rawValue
//			sortAscending = sortDescriptor.ascending
//			tableView.reloadData()
//		}
		
		print(self.netjobArray)
		
		
		let newArray = (self.netjobArray as NSArray).sortedArray(using: tableView.sortDescriptors)
		self.netjobArray = newArray as! [NetjobObj]

		tableView.reloadData()
	}
	
	func tableViewSelectionDidChange(_ notification: Notification) {
		currentSelectedItem.removeAll()
		
		for selectedRowIndex in tableView.selectedRowIndexes
		{
			currentSelectedItem.append( self.netjobArray[selectedRowIndex] as NetjobObj)
		}
		
		
		print(notification)
	}
	
	@objc func tableViewDoubleClick(_ sender:AnyObject) {
		
		// 1
		let item = self.netjobArray[tableView.selectedRow] as NetjobObj
		
		print(item.NetJobID)
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		
		var text: String = ""
		var cellIdentifier: String = ""
		
		var bgColourUse: Bool = false
		var bgColour: CGColor!
		let bgColourRed: CGColor = NSColor.red.cgColor
		let bgColourGreen: CGColor = NSColor.green.cgColor
		let bgColourOrange: CGColor = NSColor.orange.cgColor
		let bgColourWhite: CGColor = NSColor.white.cgColor
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .long
		dateFormatter.timeStyle = .long
		
		// 1
		let item = self.netjobArray[row]
		//print(item.Name)
		
		// 2
		if tableColumn == tableView.tableColumns[0] {
			text = item.Priority
			bgColourUse = true
			
			if (text == "0"||text == "1"||text == "2"||text == "3")
			{
				bgColour = bgColourGreen
			} else if (text == "4"||text == "5"||text == "6")
			{
				bgColour = bgColourOrange
			} else if (text == "7"||text == "8"||text == "9"||text == "10")
			{
				bgColour = bgColourRed
			}
			cellIdentifier = CellIdentifiers.PriorityCell
		} else if tableColumn == tableView.tableColumns[1] {
			//text = dateFormatter.string(from: item.date)
			text = item.Name
			bgColourUse = false
			cellIdentifier = CellIdentifiers.NameCell
		} else if tableColumn == tableView.tableColumns[2] {
			if (item.FrameRange != nil)
			{
				text = String(item.FrameRange.currentFrame) + "-" + String(item.FrameRange.endFrame)
			}
			bgColourUse = false
			cellIdentifier = CellIdentifiers.FrameStatusCell
		} else if tableColumn == tableView.tableColumns[3] {
			text = item.StatusText
			bgColourUse = true
			
			if (text == "Done"||text == "1"||text == "2"||text == "3")
			{
				bgColour = bgColourGreen
			} else if (text == "Rendering"||text == "5"||text == "6")
			{
				bgColour = bgColourOrange
			} else if (text == "Canceled"||text == "8"||text == "9"||text == "10")
			{
				bgColour = bgColourRed
			} else if (text == "Pending"||text == "8"||text == "9"||text == "10")
			{
				bgColour = bgColourWhite
			}
			
			
			cellIdentifier = CellIdentifiers.StatusCell
		} else if tableColumn == tableView.tableColumns[4] {
			text = item.SubmitterName
			bgColourUse = false
			cellIdentifier = CellIdentifiers.SubmittedCell
		}
		
		// 3
		if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
			cell.textField?.stringValue = text
			
			if (bgColourUse == true)
			{
				cell.wantsLayer = true
				cell.layer?.backgroundColor = bgColour
			}
			return cell
		}
		return nil
	}
	
}
