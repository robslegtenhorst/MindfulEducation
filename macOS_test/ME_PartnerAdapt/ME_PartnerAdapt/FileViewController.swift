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
    
    @IBOutlet weak var sendBTN: NSButton!
    
    var logoFile : NSString = "";
    var contentFiles : Array<[URL]> = [];
    
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
            for i in 0 ..< dialog.urls.count  {
                print(dialog.urls[i]);
            }
            
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
        
        let text = "file '"+(logoFile as String)+"'\nfile '"+(contentfileSingleUrl as String)+"'\n" //just a text
        
        let template = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("file_"+randomString(length: 6)+".txt") as NSURL
        
        var buffer = [Int8](repeating: 0, count: Int(PATH_MAX))
        template.getFileSystemRepresentation(&buffer, maxLength: buffer.count)
        
        let fd = mkstemp(&buffer)
        if fd != -1 {
            
            // Create URL from file system string:
            let url = NSURL(fileURLWithFileSystemRepresentation: buffer, isDirectory: false, relativeTo: nil)
            print(url.path!)
            
            do {
                try text.write(to: url as URL, atomically: false, encoding: String.Encoding.utf8);
                
                let filePath = Bundle.main.path(forResource: "ffmpeg", ofType: "");
                
                let path = filePath;
                let arguments = ["-f", "concat", "-safe", "0", "-i", url.path, "-y", "-codec", "copy", outputLoc+"/NEW_LOGO_"+(filename as String)];
                
                let task = Process.launchedProcess(launchPath: path!, arguments: arguments as! [String]);
                task.waitUntilExit();
                
                //filename_field.stringValue += "Completed "+outputLoc+"/output.mp4";
                
                let fileManager = FileManager.default;
                
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
        if (logoFile != "Cancel" && contentFiles.count != 0)
        {
            sendBTN.acceptsTouchEvents = false;
            sendBTN.isEnabled = false;
            
            let outputLoc = openFolderDialog();
            
            for i in 0 ..< contentFiles.count  {
                let contentfileURL : [URL] = contentFiles[i];
                for j in 0 ..< contentfileURL.count  {
                    let contentfileSingleUrl = contentfileURL[j].absoluteString as NSString;
                    let filename : NSString = contentfileSingleUrl.lastPathComponent as NSString;
                    runCMD(contentfileSingleUrl: contentfileSingleUrl, filename: filename, outputLoc : outputLoc);
                }
            }
            
            sendBTN.acceptsTouchEvents = true;
            sendBTN.isEnabled = true;
        }
        
    }
}
