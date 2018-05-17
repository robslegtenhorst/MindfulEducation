//
//  FileViewController.swift
//  ME_PartnerAdapt
//
//  Created by Rob Slegtenhorst on 09/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa

class FileController: NSViewController {
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
        
        if (dialog.runModal() == NSModalResponseOK) {
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
        
        if (dialog.runModal() == NSModalResponseOK) {
//            for i in 0 ..< dialog.urls.count  {
//                print(dialog.urls[i]);
//            }
            
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
        
        if (dialog_1.runModal() == NSModalResponseOK) {
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
        
        var subArray : Array<VTTData> = [];
        
        let fileManager = FileManager.default;
        let encodingFile = URL(fileURLWithPath: contentfileSingleUrl as String)
        let encodingFileName = encodingFile.deletingPathExtension().lastPathComponent
        let encodingFilePath = encodingFile.deletingLastPathComponent()
        
        let enumerator = FileManager.default.enumerator(atPath: encodingFilePath.path)
        let filePaths = enumerator?.allObjects as! [String]
        let vttFilePaths = filePaths.filter{$0.contains(".vtt")}
        
        for vttFileName in vttFilePaths{
//            print("VTT Name :: "+vttFileName)
//            print("original filename :: "+encodingFileName)
            
            let vttFileNameArr = vttFileName.components(separatedBy: ".")
            
            let name    = vttFileNameArr[0]
            let lang    = vttFileNameArr[1]
            
            if encodingFileName.lowercased().range(of:name.lowercased()) != nil {
                let vttFile = URL(fileURLWithPath: encodingFilePath.path + "/" + vttFileName)
                
                let vttFileLang = lang
                
                let vttData = VTTData(vttURL: vttFile, vttLang: vttFileLang);
                
                // TODO this search works, but if there's subs that contain a wrong file name (e.g. LOGO_aat-l2_u01_l.en-GB.vtt > missing lesson and part) they will be matched to everything. avoid by using correct filenames :)
                
                subArray.append(vttData)
            }
        }
        
        let text = "file '"+(logoFile as String)+"'\nfile '"+(contentfileSingleUrl as String)+"'\n" //just a text
        
        let template = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("file_"+randomString(length: 6)+".txt") as NSURL
        
        var buffer = [Int8](repeating: 0, count: Int(PATH_MAX))
        template.getFileSystemRepresentation(&buffer, maxLength: buffer.count)
        
        let fd = mkstemp(&buffer)
        if fd != -1 {
            
            // Create URL from file system string:
            let url = NSURL(fileURLWithFileSystemRepresentation: buffer, isDirectory: false, relativeTo: nil)
//            print(url.path!)
            
            do {
                try text.write(to: url as URL, atomically: false, encoding: String.Encoding.utf8);
                
                let filePath = Bundle.main.path(forResource: "ffmpeg", ofType: "");
                
                let path = filePath;
                let newFilename = filename.replacingOccurrences(of: "LOGO_", with: "")
                let outputFile = outputLoc+"/"+(collegeName.stringValue)+"_"+(newFilename as String)
                
                let file_name = NSURL(fileURLWithPath: outputFile).deletingPathExtension?.lastPathComponent
                
//                print("file_name :: "+file_name!)
                
                let arguments = ["-loglevel", "error", "-auto_convert", "1", "-f", "concat", "-safe", "0", "-i", url.path, "-y", "-codec", "copy", outputFile];
                
                let task = Process.launchedProcess(launchPath: path!, arguments: arguments as! [String]);
                task.waitUntilExit();
                
                //filename_field.stringValue += "Completed "+outputLoc+"/output.mp4";
                
                if (self.uploadBool == true) {addVideoToVimeo(outputFile:outputFile, file_name:file_name!, vttDataArray:subArray);}
                
                do {
                    try fileManager.removeItem(atPath: url.path!)
                }
                catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
                
            }
            catch {/* error handling here */}
            
        } else {
            print("Error: " + String(cString: strerror(errno)))
        }
        
        return;
    }
    
    func addVideoToVimeo(outputFile:String, file_name:String, vttDataArray:Array<VTTData>) -> Void {
        print("Video converted succesfully, attempting to upload to Vimeo")
//        print("group_uri :: "+self.group_uri)
        
        let filePath = "/usr/bin/php";
        
        let path = filePath;
        
//        print(vttDataArray.count)
        
        // TODO Add php file to package
        // TODO add php exec to package?
        
//        var arguments = ["/Applications/XAMPP/xamppfiles/htdocs/vimeo/example/upload_vidText.php", self.group_uri, outputFile, file_name, "2", "/Users/robslegtenhorst/RENDER/temp_logo/subs/CAR_AAT-L2_U01/car_aat-l2_u01_l01_p01_v007_MASTERED/car_aat-l2_u01_l01_p01_v007_MASTERED.en-GB_Welsh.vtt", "cy", "/Users/robslegtenhorst/RENDER/temp_logo/subs/CAR_AAT-L2_U01/car_aat-l2_u01_l01_p01_v007_MASTERED/English (United Kingdom).vtt", "en-GB"];
        
        var arguments = ["/Applications/XAMPP/xamppfiles/htdocs/vimeo/example/upload_vidText.php", self.group_uri, outputFile, file_name];
        
        arguments.append(vttDataArray.count.description)
        
        for i in 0 ..< vttDataArray.count  {
            arguments.append(vttDataArray[i].vttURL.path)
            arguments.append(vttDataArray[i].vttLang)
        }
        
//        for j in 0 ..< arguments.count{
//            print(arguments[j])
//        }
        
        let task = Process.launchedProcess(launchPath: path, arguments: arguments );
        task.waitUntilExit();
        
//        print("COMPLETED")
        
    }
    
    @IBAction func SelectLogoBtn(_ sender: NSButton) {
        logoFile = openFileDialog();
        
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
        
        if (logoFile != "Cancel" && contentFiles.count != 0 && collegeName.stringValue != "")
        {
            if (groupName.stringValue != "" || GroupID.stringValue != "")
            {
                sendBTN.acceptsTouchEvents = false;
                sendBTN.isEnabled = false;
                
                let myGroup = DispatchGroup()
                myGroup.enter()
                
                if (GroupID.stringValue != "") {
                    self.group_uri = "/users/42291155/albums/"+GroupID.stringValue
                } else {
                    // create group on vimeo
                    if (self.uploadBool == true) {createGroupPHPCall(albumName: groupName.stringValue)}
                }
                
    //            print("received self.group_uri :: "+self.group_uri)
                myGroup.leave()
                myGroup.notify(queue: DispatchQueue.main) {
                    let outputLoc = self.openFolderDialog();
                    
                    for i in 0 ..< self.contentFiles.count  {
                        let contentfileURL : [URL] = self.contentFiles[i];
                        for j in 0 ..< contentfileURL.count  {
                            let contentfileSingleUrl = contentfileURL[j].absoluteString as NSString;
                            let filename : NSString = contentfileSingleUrl.lastPathComponent as NSString;
                            self.runCMD(contentfileSingleUrl: contentfileSingleUrl, filename: filename, outputLoc : outputLoc);
                        }
                    }
                    
                    self.sendBTN.acceptsTouchEvents = true;
                    self.sendBTN.isEnabled = true;
                    
                    // create csv from group
                    
                    let AlbumID = NSURL(fileURLWithPath: self.group_uri).lastPathComponent
                    if (self.uploadBool == true) {self.albumCSVPHPCall(PageNR: 1, AlbumID: AlbumID!, perPage: 50, getSubs:false);}
                }
            } else {
                var message = ""
                
                if (logoFile == "") {message += "Select a Logo File\n"}
                if (contentFiles.count == 0) {message += "Select Some content files\n"}
                if (groupName.stringValue == "" && GroupID.stringValue == "") {message += "Add a name or group ID for the group on Vimeo\n"}
                if (collegeName.stringValue == "") {message += "Add a name for the College\n"}
                
                
                
                let answer = dialogOKCancel(question: "Ok", text: message)
                if (answer){
                    print("ok")
                }
            }
        } else {
            
            var message = ""
            
            if (logoFile == "") {message += "Select a Logo File\n"}
            if (contentFiles.count == 0) {message += "Select Some content files\n"}
            if (groupName.stringValue == "" && GroupID.stringValue == "") {message += "Add a name or group ID for the group on Vimeo\n"}
            if (collegeName.stringValue == "") {message += "Add a name for the College\n"}
            
            
            
            let answer = dialogOKCancel(question: "Ok", text: message)
            if (answer){
                print("ok")
            }
        }
        
    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        return alert.runModal() == NSAlertFirstButtonReturn
    }
    
    @IBAction func UploadCheckbox(_ sender: Any) {
        if (self.uploadBool == true) {
            self.uploadBool = false
        } else {
            self.uploadBool = true
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
                                self.albumCSVPHPCall(PageNR: nextPageNR, AlbumID: AlbumID, perPage: perPage, getSubs:getSubs);
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
    
    func createGroupPHPCall(albumName:String) -> Void {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/createGroup.php?albumName="+albumName)!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let session = URLSession.shared
        
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
                        
                        if (status == 201)
                        {
                            if (dictionary["headers"] as? [String: Any]) != nil
                            {
                                //print(headersDictionary)
                            }
                            
                            if let bodyDictionary = dictionary["body"] as? [String: Any]
                            {
                                self.group_uri = bodyDictionary["uri"] as! String
                                self.group_link = bodyDictionary["link"] as! String
//                                print("received album_uri :: "+self.group_uri)
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
    
    @IBAction func TestBtn(_ sender: NSButton) {
        print("button clicked, fingers crossed")
        let filePath = "/usr/bin/php";
        let path = filePath;
        
        let arguments = ["/Applications/XAMPP/xamppfiles/htdocs/vimeo/example/quota.php"];
        
        let task = Process.launchedProcess(launchPath: path, arguments: arguments );
        task.waitUntilExit();
    }
}
