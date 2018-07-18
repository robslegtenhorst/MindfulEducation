//
//  PartOneViewController.swift
//  MindfulVimeo
//
//  Created by Rob Slegtenhorst on 28/06/2018.
//  Copyright © 2018 Rob Slegtenhorst. All rights reserved.
//

//TODO progressbar
//TODO disable interface until all encodes and uploads are completed
//TODO convert php upload to node
//TODO convert vtt upload to node
//TODO convert csv to node
//TODO fix callsequence, create album > convert video > upload video > attach vtt > repeat until done > create csv
//TODO create poster frame button
//TODO create just csv button
//TODO download all items from album
//TODO cleanup interface

import Foundation
import Cocoa

struct AlbumData: Decodable {
    let uri: String?
    let link: String?
    let xRatelimitRemaining: String?
    let statusCode: Int?
    enum AlbumData : String, CodingKey {
        case uri
        case link
        case xRatelimitRemaining
        case statusCode
    }
}

struct VideoUploadData: Decodable {
    let uri: String?
    let videoUri: String?
    let link: String?
    let xRatelimitRemaining: String?
    let statusCode: Int?
    enum VideoUploadData : String, CodingKey {
        case uri
        case videoUri
        case link
        case xRatelimitRemaining
        case statusCode
    }
}

enum FFPROBEError: Error {
    case invalidJSON
}

struct VideoData: Decodable {
    let streams: [VideoDataStreams]
    enum CodingKeys : String, CodingKey {
        case streams = "streams"
    }
}

struct VideoDataStreams: Decodable {
    let level: Int
    let nb_frames: String
}

class PartOneViewController: NSViewController {
    
    let vimeoUserID = "42291155"
    
    let nodePath = Bundle.main.path(forResource: "node", ofType: "");
    let ffprobePath = Bundle.main.path(forResource: "ffprobe", ofType: "");
    let ffmpegPath = Bundle.main.path(forResource: "ffmpeg", ofType: "");
    
    let VimeoAlbumCreateNode = Bundle.main.path(forResource: "me_CreateAlbum", ofType: "js", inDirectory: "NodeFiles/VimeoFiles");
    let VimeoUploadNode = Bundle.main.path(forResource: "me_uploadVideo", ofType: "js", inDirectory: "NodeFiles/VimeoFiles");
    
    let VimeoTTUploadPHP = Bundle.main.path(forResource: "upload_texttrack", ofType: "php", inDirectory: "PHPFiles/example");
    
    @IBOutlet weak var LogoText: NSTextField!
    
    @IBOutlet weak var ContentText: NSTextField!
    
    @IBOutlet weak var groupName: NSTextField!
    @IBOutlet weak var collegeName: NSTextField!
    
    @IBOutlet weak var GroupID: NSTextField!
    
    @IBOutlet weak var sendBTN: NSButton!
    var logoFile : NSString = "";
    var contentFiles : Array<[URL]> = [];
    
    var group_uri:String = "";
    var group_link:String = "";
    var group_name:String = "";
    
    var totalItems:Double = 0.0;
    var repeatPages:Double = 0.0
    var albumNR:String = ""
    
    var uploadBool:Bool = true
    
    var tempReturnedItemArray:Array<VimeoData> = [];
    var returnedItemArray : Array<VimeoData> = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func openFileDialog() -> NSString {
        let dialog = NSOpenPanel();
        dialog.title = "Choose a video...";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["mp4"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path_1 = result!.path
                return path_1 as NSString
            }
        } else {
            // User clicked on "Cancel"
            return "Cancelled"
        }
        
        return "Cancelled"
    }
    
    func openFilesDialog() -> Array<[URL]> {
        let dialog = NSOpenPanel();
        dialog.title = "Choose a video...";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = true;
        dialog.allowedFileTypes        = ["mp4"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            
            let result = dialog.urls // Pathname of the file
            
            if (result.count != 0) {
                return [dialog.urls]
            }
        } else {
            // User clicked on "Cancel"
            return []
        }
        
        return []
    }
    
    func openFolderDialog() -> String {
        let dialog_1 = NSOpenPanel();
        dialog_1.title = "Choose a folder...";
        dialog_1.showsResizeIndicator    = true;
        dialog_1.showsHiddenFiles        = false;
        dialog_1.canChooseDirectories    = true;
        dialog_1.canChooseFiles          = false;
        dialog_1.canCreateDirectories    = true;
        dialog_1.allowsMultipleSelection = false;
        
        if (dialog_1.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog_1.url // Pathname of the file
            
            if (result != nil) {
                let path_1 = result!.path
                return path_1
            }
        } else {
            // User clicked on "Cancel"
            return "Cancel"
        }
        
        return "Cancel"
    }
    
    func runCMD(contentfileSingleUrl:NSString, filename:NSString, outputLoc:String) -> Void {
        //This is the big one. concats or encodes each video, based on level differences. uses ffprobe and ffmpeg for these tasks. then uploads the converted video to the correct folder on vimeo, and adds subtitles if they exist.
        
        let encodingFile = URL(fileURLWithPath: contentfileSingleUrl as String)
        let encodingFileName = encodingFile.deletingPathExtension().lastPathComponent
        let encodingFilePath = encodingFile.deletingLastPathComponent()
        
        //VTT Search
        let subArray : Array<VTTData> = VTTSearch(encodingFilePath:encodingFilePath, encodingFileName:encodingFileName)
        
        //FFPROBE the 2 video files, and check what each level and frame length is. if the level differs, encode the file, otherwise concat (way faster)
        
        let FFPROBE_videofileOneDataDecoded = probeVideoFile(videoPath: logoFile as String)
        let FFPROBE_videofileTwoDataDecoded = probeVideoFile(videoPath: contentfileSingleUrl as String)
        let FFPROBE_totalFrames = Int(FFPROBE_videofileOneDataDecoded.streams[0].nb_frames)! + Int(FFPROBE_videofileTwoDataDecoded.streams[0].nb_frames)!
        
        print("video 1 level: \(FFPROBE_videofileOneDataDecoded.streams[0].level)")
        print("video 1 frames: \(FFPROBE_videofileOneDataDecoded.streams[0].nb_frames)")
        print("video 2 level: \(FFPROBE_videofileTwoDataDecoded.streams[0].level)")
        print("video 2 frames: \(FFPROBE_videofileTwoDataDecoded.streams[0].nb_frames)")
        
//        Check returned level against first video, if mismatch, re-encode videos
        if (FFPROBE_videofileOneDataDecoded.streams[0].level == FFPROBE_videofileTwoDataDecoded.streams[0].level)
        {
            concatVideos(video_1:logoFile as String, video_2:contentfileSingleUrl as String, filename:filename, outputLoc:outputLoc, subArray:subArray, totalFrames:FFPROBE_totalFrames)
        } else {
            encodeVideos(video_1:logoFile as String, video_2:contentfileSingleUrl as String, filename:filename, outputLoc:outputLoc, subArray:subArray, totalFrames:FFPROBE_totalFrames)
        }
        
        return;
    }
    
    func addVideoToVimeo(outputFile:String, file_name:String, vttDataArray:Array<VTTData>) -> Void {
        print("Video converted succesfully, attempting to upload to Vimeo")
        print("self.group_uri :: "+self.group_uri)
        print("outputFile :: "+outputFile)
        print("file_name :: "+file_name)
        
        let uploadArguments: [String] = [VimeoUploadNode!, self.group_uri, "/Users/robslegtenhorst/_RENDER/temp_test/fine/test_2.mp4", file_name, "0"]
        let uploadNodeString = shell(launchPath: nodePath!, arguments: uploadArguments)
        let uploadDataUTF : Data = uploadNodeString.data(using: .utf8)!
        
//        print("uploadNodeString::"+uploadNodeString)
        
        guard let videoUploadDataDecoded = try? JSONDecoder().decode(VideoUploadData.self, from: uploadDataUTF) else {
            print("Error: Couldn't decode data into VideoUploadData")
            return
        }
        
        print("xRatelimitRemaining::"+videoUploadDataDecoded.xRatelimitRemaining!)
        print("uri::"+videoUploadDataDecoded.uri!)
        print("videoUri::"+videoUploadDataDecoded.videoUri!)
        
        
        
        
        //        print("group_uri :: "+self.group_uri)
        
        let filePath = "/usr/bin/php";
        
        let path = filePath;
        
        //        print(vttDataArray.count)
        
        // TODO Add php file to package
        // TODO add php exec to package?
        
        //        var arguments = ["/Applications/XAMPP/xamppfiles/htdocs/vimeo/example/upload_vidText.php", self.group_uri, outputFile, file_name, "2", "/Users/robslegtenhorst/RENDER/temp_logo/subs/CAR_AAT-L2_U01/car_aat-l2_u01_l01_p01_v007_MASTERED/car_aat-l2_u01_l01_p01_v007_MASTERED.en-GB_Welsh.vtt", "cy", "/Users/robslegtenhorst/RENDER/temp_logo/subs/CAR_AAT-L2_U01/car_aat-l2_u01_l01_p01_v007_MASTERED/English (United Kingdom).vtt", "en-GB"];
        
        var arguments = [VimeoTTUploadPHP, videoUploadDataDecoded.uri, self.group_uri, videoUploadDataDecoded.videoUri];
        
        arguments.append(vttDataArray.count.description)

        for i in 0 ..< vttDataArray.count  {
            arguments.append(vttDataArray[i].vttURL.path)
            arguments.append(vttDataArray[i].vttLang)
        }
        
        //        for j in 0 ..< arguments.count{
        //            print(arguments[j])
        //        }
        
        let task = Process.launchedProcess(launchPath: path, arguments: arguments as! [String] );
        task.waitUntilExit();
        
        //        print("COMPLETED")
        
    }
    
    @IBAction func SelectLogoBtn(_ sender: NSButton) {
        self.logoFile = openFileDialog();
        
        let filename : NSString = logoFile.lastPathComponent as NSString;
        
        LogoText.stringValue = filename as String;
    }
    
    
    @IBAction func SelectContentFiles(_ sender: NSButton) {
        contentFiles = openFilesDialog();
        
        var contentFileNames : String = "";
        
        for i in 0 ..< contentFiles.count  {
            var contentfileURL : [URL] = contentFiles[i];
            for j in 0 ..< contentfileURL.count  {
                let contentfileSingleUrl = contentfileURL[j].absoluteString as NSString;
                let filename : NSString = contentfileSingleUrl.lastPathComponent as NSString;
                
                contentFileNames += (filename as String) + "\n";
            }
            
        }
        
        ContentText.stringValue = contentFileNames;
    }
    
    
    @IBAction func RunBtn(_ sender: NSButton) {
        
        var message = ""
        
        // Check if all values are entered
        
        if (logoFile == "Cancel" || contentFiles.count == 0 || collegeName.stringValue == "")
        {
            message = ""
            
            if (logoFile == "") {message += "-Select a Logo File\n"}
            if (contentFiles.count == 0) {message += "-Select Some content files\n"}
            if (self.uploadBool == true){if (groupName.stringValue == "" && GroupID.stringValue == "") {message += "-Add a name or group ID for the group on Vimeo\n"}
            else if (groupName.stringValue != "" && GroupID.stringValue != ""){message += "-Enter either name or group ID for the group on Vimeo, not both\n"}
            }
            if (collegeName.stringValue == "") {message += "-Add a name for the College\n"}
            
            let answer = dialogOKCancel(question: "Ok", text: message)
            if (answer){
                print("ok")
            }
            return
        } else if (self.uploadBool == true) {
            if (groupName.stringValue == "" && GroupID.stringValue == "")
            {
                message = ""
                
                if (logoFile == "") {message += "-Select a Logo File\n"}
                if (contentFiles.count == 0) {message += "-Select Some content files\n"}
                if (self.uploadBool == true){if (groupName.stringValue == "" && GroupID.stringValue == "") {message += "-Add a name or group ID for the group on Vimeo\n"}}
                if (collegeName.stringValue == "") {message += "-Add a name for the College\n"}
                
                let answer = dialogOKCancel(question: "Ok", text: message)
                if (answer){
                    print("ok")
                }
                return
            } else if (groupName.stringValue != "" && GroupID.stringValue != "")
                {
                    message = ""
                    
                    message += "-Enter either name or group ID for the group on Vimeo, not both\n"
                    if (logoFile == "") {message += "-Select a Logo File\n"}
                    if (contentFiles.count == 0) {message += "-Select Some content files\n"}
                    if (collegeName.stringValue == "") {message += "-Add a name for the College\n"}
                    
                    let answer = dialogOKCancel(question: "Ok", text: message)
                    if (answer){
                        print("ok")
                    }
                    return
            }
        }
        
        // Disable send button
        sendBTN.acceptsTouchEvents = false;
        sendBTN.isEnabled = false;
        
        //get output folder
        let outputLoc = self.openFolderDialog();
        
        if (outputLoc == "Cancel") {
            self.sendBTN.acceptsTouchEvents = true;
            self.sendBTN.isEnabled = true;
            return
        }
        
        //create folder on vimeo if needed
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        if (GroupID.stringValue != "") {
            self.group_uri = "/users/"+self.vimeoUserID+"/albums/"+GroupID.stringValue
        } else {
            // create group on vimeo
            self.group_name = groupName.stringValue
            
            if (self.uploadBool == true) {createGroupNodeCall(albumName: groupName.stringValue)}
        }
        
        myGroup.leave()
        
        myGroup.notify(queue: DispatchQueue.main) {
            
            for i in 0 ..< self.contentFiles.count  {
                let contentfileURL : [URL] = self.contentFiles[i];
                for j in 0 ..< contentfileURL.count  {
                    let contentfileSingleUrl = contentfileURL[j].absoluteString.replacingOccurrences(of: "%20", with: " ") as NSString;
                    let filename : NSString = contentfileSingleUrl.lastPathComponent as NSString;
                    self.runCMD(contentfileSingleUrl: contentfileSingleUrl, filename: filename, outputLoc : outputLoc);
                }
            }
            
            // create csv from group
            
            let AlbumID = NSURL(fileURLWithPath: self.group_uri).lastPathComponent
            
            // enable this again for CSV
            
//            if (self.uploadBool == true) {self.albumCSVPHPCall(PageNR: 1, AlbumID: AlbumID!, perPage: 50, getSubs:false, albumName: self.group_name as NSString);}
            
            
            self.sendBTN.acceptsTouchEvents = true;
            self.sendBTN.isEnabled = true;
        }
        
    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        return alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
    }
    
    @IBAction func UploadCheckbox(_ sender: Any) {
        if (self.uploadBool == true) {
            self.uploadBool = false
            self.groupName.acceptsTouchEvents = false;
            self.groupName.isEnabled = false;
            self.GroupID.acceptsTouchEvents = false;
            self.GroupID.isEnabled = false;
        } else {
            self.uploadBool = true
            self.groupName.acceptsTouchEvents = true;
            self.groupName.isEnabled = true;
            self.GroupID.acceptsTouchEvents = true;
            self.GroupID.isEnabled = true;
        }
        
        print("uploadBool :: "+uploadBool.description)
    }
    
    func albumCSVPHPCall(PageNR:Double, AlbumID:String, perPage:Double, getSubs:Bool, albumName:NSString = "") {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/index.php?album="+AlbumID+"&page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=link,name,metadata,duration,created_time,modified_time,release_time,download")!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let session = URLSession.shared
        
        self.tempReturnedItemArray = [];
        
        let task = session.dataTask(with: request as URLRequest)
        {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200)
            {
                do
                {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    
                    if let dictionary = json as? [String: Any]
                    {
                        
                        let status:NSNumber = (dictionary["status"] as? NSNumber)!;
                        
                        if (status == 200)
                        {
                            if (dictionary["headers"] as? [String: Any]) != nil
                            {
                                //print(headersDictionary)
                            }
                            
                            if let bodyDictionary = dictionary["body"] as? [String: Any]
                            {
                                if (self.totalItems == 0)
                                {
                                    self.totalItems = (bodyDictionary["total"] as? Double)!; //332
                                    let perPage:Double = (bodyDictionary["per_page"] as? Double)!; //50
                                    
                                    if (perPage < self.totalItems)
                                    {
                                        //ENABLE FOR PAGING
                                        //                                        self.repeatPages = ceil(self.totalItems / perPage);
                                        print(self.repeatPages);
                                    }
                                }
                                
                                // contains total, per page & page nr
                                
                                if let dataArr = bodyDictionary["data"] as? NSArray
                                {
                                    //                                    print(dataArr)
                                    
                                    for i in 0 ..< dataArr.count
                                    {
                                        let dataDic = dataArr[i] as! NSDictionary;
                                        let name = dataDic["name"] as! NSString;
                                        let link = dataDic["link"] as! NSString;
                                        
                                        let duration = dataDic["duration"] as! NSNumber;
                                        let created_time = dataDic["created_time"] as! NSString;
                                        let modified_time = dataDic["modified_time"] as! NSString;
                                        let release_time = dataDic["release_time"] as! NSString;
                                        
                                        let metadata = dataDic["metadata"] as! NSDictionary;
                                        let connections = metadata["connections"] as! NSDictionary;
                                        let texttracks = connections["texttracks"] as! NSDictionary;
                                        let texttracks_total = texttracks["total"] as! NSNumber;
                                        //let texttracks_uri = texttracks["uri"] as! NSString;
                                        
                                        
                                        let itemData = VimeoData(dataDic:dataDic, name:name, link:link, texttracks_total:texttracks_total, duration:duration, created_time:created_time, modified_time:modified_time, release_time:release_time, subtitle_url:"FUNC DISABLED", downloadLink: "" as NSString, albumID: AlbumID as NSString, videoType: "", complete:false);
                                        
                                        self.tempReturnedItemArray.append(itemData)
                                        //                                        print("filled array with :: "+self.tempReturnedItemArray.count.description)
                                        
                                    }
                                    
                                }
                            }
                            
                            if (PageNR >= self.repeatPages)
                            {
                                if (getSubs){
                                    //self.getSubs(contentArray: self.tempReturnedItemArray)
                                } else {
                                    //ENABLE FOR PAGING
                                    //                                    self.createCSV(AlbumID:AlbumID, contentArray: self.returnedItemArray);
                                    self.createCSV(AlbumID:AlbumID, albumName:albumName as String, contentArray: self.tempReturnedItemArray);
                                }
                                
                            } else {
                                let nextPageNR = PageNR + 1;
                                self.albumCSVPHPCall(PageNR: nextPageNR, AlbumID: AlbumID, perPage: perPage, getSubs:getSubs, albumName: albumName);
                            }
                        } else {
                            print("Content returned error :: "+status.description);
                        }
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
            }
        }
        
        task.resume();
    }
    
    func createCSV(AlbumID:String, albumName:String, contentArray:Array<VimeoData>) {
        //        print("creating csv for "+contentArray.count.description+" items");
        
        let AlbumID = NSURL(fileURLWithPath: self.group_uri).lastPathComponent
        
        let file = AlbumID!+"_"+albumName+".csv"
        var text = "AlbumID,"+AlbumID!+",Album Name,"+albumName+"\n"
        text.append("ID, Name, URL, Subtitles, duration, Created, Modified, Release\n")
        
        for i in 0 ..< contentArray.count
        {
            let tempVimeoData : VimeoData = contentArray[i];
            let tempVideoID : String = (tempVimeoData.link as NSString).lastPathComponent;
            
            //            print("looping")
            
            //            print(tempVimeoData.link)
            
            text.append(tempVideoID);
            text.append(",");
            text.append(tempVimeoData.name as String);
            text.append(",");
            text.append(tempVimeoData.link as String);
            text.append(",");
            text.append(tempVimeoData.subtitle_url as String);
            text.append(",");
            text.append((tempVimeoData.duration as NSNumber).description);
            text.append(",");
            text.append(tempVimeoData.created_time as String);
            text.append(",");
            text.append(tempVimeoData.modified_time as String);
            text.append(",");
            text.append(tempVimeoData.release_time as String);
            text.append("\n");
            
        }
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    func createGroupNodeCall(albumName:String) -> Void {
        print("Creating album with node")
        
        let arguments: [String] = [VimeoAlbumCreateNode!, albumName]
        let albumDataString = shell(launchPath: nodePath!, arguments: arguments)
        let albumDataUTF : Data = albumDataString.data(using: .utf8)!
        
        print("albumDataString::"+albumDataString)
        
        guard let albumDataDecoded = try? JSONDecoder().decode(AlbumData.self, from: albumDataUTF) else {
            print("Error: Couldn't decode data into AlbumData")
            return
        }
        
        if (albumDataDecoded.statusCode == 201)
        {
            self.group_uri = albumDataDecoded.uri!
            self.group_link = albumDataDecoded.link!
        } else {
            print("Content returned error :: "+(albumDataDecoded.statusCode?.description)!);
        }
        
        print("albumDataDecoded.uri::"+albumDataDecoded.uri!)
        print("albumDataDecoded.xRatelimitRemaining::"+albumDataDecoded.xRatelimitRemaining!)
        print("albumDataDecoded.statusCode::"+(albumDataDecoded.statusCode?.description)!)
    }
    
    func VTTSearch(encodingFilePath:URL, encodingFileName:String) -> Array<VTTData> {
        //search next to video files for vtt's. vtt's filenaming should match <filename of the video being uploaded without version>.<lang>.vtt - do not use '.' in the filename, as that's where the function splits the name and lang
        //result is an array filled with different languages
        
        var subArray : Array<VTTData> = [];
        
        let enumerator = FileManager.default.enumerator(atPath: encodingFilePath.path)
        let filePaths = enumerator?.allObjects as! [String]
        let vttFilePaths = filePaths.filter{$0.contains(".vtt")}
        
        for vttFileName in vttFilePaths{
            print("VTT Name :: "+vttFileName)
            print("original filename :: "+encodingFileName)
            
            let vttFileNameArr = vttFileName.components(separatedBy: ".")
            
            let name    = vttFileNameArr[0]
            let lang    = vttFileNameArr[1]
            
            if encodingFileName.lowercased().range(of:name.lowercased()) != nil {
                let vttFile = URL(fileURLWithPath: encodingFilePath.path + "/" + vttFileName)
                
                let vttFileLang = lang
                
                let vttData = VTTData(vttURL: vttFile, vttLang: vttFileLang);
                
                // this search works, but if there's subs that contain a wrong file name (e.g. LOGO_aat-l2_u01_l.en-GB.vtt > missing lesson and part) they will be matched to everything. avoid by using correct filenames :)
                
                // e.g. aat-l2_u01.en-GB.vtt will match LOGO_aat-l2_u01_l01_p01_v008_MASTERED and LOGO_aat-l2_u01_l02_p01_v008 etc (search checks if video filename contains sub name)
                
                subArray.append(vttData)
            }
        }
        
        return subArray
    }
    
    func probeVideoFile(videoPath:String) -> VideoData
    {
        
        print(videoPath)
        var FFPROBE_videofileDataDecoded:VideoData!
        
        let FFPROBE_Arguments: [String] = ["-v", "quiet", "-print_format", "json", "-show_streams", "-select_streams", "v:0", "-show_entries","stream=level,nb_frames", videoPath]
        let FFPROBE_DataString = shell(launchPath: ffprobePath!, arguments: FFPROBE_Arguments)
        let FFPROBE_videofileData : Data = FFPROBE_DataString.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            FFPROBE_videofileDataDecoded = try decoder.decode(VideoData.self, from: FFPROBE_videofileData)
        } catch let error {
            print("Error: Couldn't decode data into VideoData")
            print(error)
        }
    
        return FFPROBE_videofileDataDecoded
    }
    
    func concatVideos(video_1:String, video_2:String, filename:NSString, outputLoc:String, subArray:Array<VTTData>, totalFrames:Int) -> Void {
        //create temp text file for ffmpeg concat
        let text = "file '"+video_1+"'\nfile '"+video_2+"'\n"
        let textUTF = Data(text.utf8)
        let tempFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(String("file_"+randomString(length: 6)+".txt"))
        
        do {
            try textUTF.write(to: tempFileURL, options: .atomic);
            
            let path = ffmpegPath;
            let newFilename = filename.replacingOccurrences(of: "LOGO_", with: "")
            let outputFile = outputLoc+"/"+(collegeName.stringValue)+"_"+(newFilename as String)
            
            let file_name = NSURL(fileURLWithPath: outputFile).deletingPathExtension?.lastPathComponent
            
            let concatArgs = ["-loglevel", "error", "-auto_convert", "1", "-f", "concat", "-safe", "0", "-i", tempFileURL.path, "-y", "-codec", "copy", outputFile]
            
            concatShell(launchPath: path!, arguments: concatArgs , totalFrames: totalFrames, tempFileURL: tempFileURL)
            
            //TODO This is being called to early, and uploading broken file...
            if (self.uploadBool == true) {addVideoToVimeo(outputFile:outputFile, file_name:file_name!, vttDataArray:subArray);}
            
        } catch {print("spotted an error")}
    }
    
    func encodeVideos(video_1:String, video_2:String, filename:NSString, outputLoc:String, subArray:Array<VTTData>, totalFrames:Int) -> Void {
        let path = ffmpegPath;
        let newFilename = filename.replacingOccurrences(of: "LOGO_", with: "")
        let outputFile = outputLoc+"/"+(collegeName.stringValue)+"_"+(newFilename as String)
        
        let file_name = NSURL(fileURLWithPath: outputFile).deletingPathExtension?.lastPathComponent
        
        let encodeArgs = ["-y","-hide_banner", "-v", "quiet", "-stats", "-i", video_1, "-i", video_2, "-filter_complex", "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]", "-map", "[outv]", "-map", "[outa]", outputFile]
        
        concatShell(launchPath: path!, arguments: encodeArgs , totalFrames: totalFrames, tempFileURL: nil)
        //TODO not sure if this is being called
        
        //TODO This is being called to early, and uploading broken file...
        if (self.uploadBool == true) {addVideoToVimeo(outputFile:outputFile, file_name:file_name!, vttDataArray:subArray);}
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
    
    func concatShell(launchPath: String, arguments: [String], totalFrames: Int, tempFileURL:URL?) -> Void
    {
        let fileManager = FileManager.default;
        
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
//                                                                print("output: \(str)")
                                                                print("Frame: \(currentframeArray[1]) of \(totalFrames)")
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
                                                        if (tempFileURL != nil){
                                                            do {
                                                                try fileManager.removeItem(atPath: (tempFileURL?.path)!)
                                                            }
                                                            catch let error as NSError {
                                                                print("Ooops! Temp file not removed: \(error)")
                                                            }
                                                        }
                                                        NotificationCenter.default.removeObserver(obs2)
        }
        task.launch()
    }
    
}

extension NSString {
    var condensedWhitespace: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
