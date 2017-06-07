//
//  PHPController.swift
//  ME_PartnerAdapt
//
//  Created by Rob Slegtenhorst on 17/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa

class PHPController: NSViewController {
    
    @IBOutlet weak var AlbumID: NSTextField!
    
    var totalItems:Double = 0.0;
    var repeatPages:Double = 0.0
    var albumNR:String = ""
    
    var returnedAlbumArray : Array<VimeoAlbumData> = [];
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
    
    func allAlbumPHPCall(PageNR:Double, perPage:Double, getSubs:Bool) {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/vimeo_album.php?page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=uri,name")!
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
                        
                        if (status == 200)
                        {
//                            print(dictionary)
                            
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
                                        self.repeatPages = ceil(self.totalItems / perPage);
                                        print(self.repeatPages);
                                    }
                                }
                                
                                // contains total, per page & page nr
                                
                                if let dataArr = bodyDictionary["data"] as? NSArray
                                {
                                    
                                    for i in 0 ..< dataArr.count
                                    {
                                        let dataDic = dataArr[i] as! NSMutableDictionary;
                                        let uri = dataDic["uri"] as! NSString;
                                        let name = dataDic["name"] as! NSString;
                                        
                                        let itemData = VimeoAlbumData(dataDic:dataDic, uri:uri, name:name);
                                        
                                        self.returnedAlbumArray.append(itemData);
                                        
                                    }
                                    
                                }
                            }
                            
                            if (PageNR >= self.repeatPages)
                            {
                                for i in 0 ..< self.returnedAlbumArray.count
                                {
                                    let tempAlbumID = (self.returnedAlbumArray[i].uri as NSString).lastPathComponent;
                                    self.albumPHPCall(PageNR: 1, AlbumID: tempAlbumID, perPage: perPage, getSubs:getSubs, albumName:self.returnedAlbumArray[i].name);
                                }
                                
                            } else {
                                let nextPageNR = PageNR + 1;
                                self.allAlbumPHPCall(PageNR: nextPageNR, perPage: perPage, getSubs:getSubs);
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
    
    func albumPHPCall(PageNR:Double, AlbumID:String, perPage:Double, getSubs:Bool, albumName:NSString = "") {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/index.php?album="+AlbumID+"&page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=link,name,metadata,duration,created_time,modified_time,release_time")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let session = URLSession.shared
        
        var tempReturnedItemArray:Array<VimeoData> = [];
        
        print (PageNR);
        
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
                                    print(dataArr)
                                    
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
                                        
                                        let itemData = VimeoData(dataDic:dataDic, name:name, link:link, texttracks_total:texttracks_total, duration:duration, created_time:created_time, modified_time:modified_time, release_time:release_time, subtitle_url:"FUNC DISABLED", complete:false);
                                        
                                        //ENABLE FOR PAGING
//                                        self.returnedItemArray.append(itemData);
                                        
                                        tempReturnedItemArray.append(itemData);
                                        
                                    }
                                    
                                }
                            }
                            
                            if (PageNR >= self.repeatPages)
                            {
                                if (getSubs){
                                    self.getSubs(contentArray: tempReturnedItemArray)
                                } else {
                                    //ENABLE FOR PAGING
//                                    self.createCSV(AlbumID:AlbumID, contentArray: self.returnedItemArray);
                                    self.createCSV(AlbumID:AlbumID, albumName:albumName as String, contentArray: tempReturnedItemArray);
                                }
                                
                            } else {
                                let nextPageNR = PageNR + 1;
                                self.albumPHPCall(PageNR: nextPageNR, AlbumID: AlbumID, perPage: perPage, getSubs:getSubs);
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
    
    func getSubtitle(videoID:String, currentIndex : NSInteger) {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/vimeo_subtitle.php?video="+videoID)!
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
                        
                        if (status == 200)
                        {
                            
                            if let bodyDictionary = dictionary["body"] as? [String: Any]
                            {
                                if let dataArr = bodyDictionary["data"] as? NSArray
                                {
                                    for i in 0 ..< dataArr.count
                                    {
                                        let dataDic = dataArr[i] as! NSMutableDictionary;
                                        let link = dataDic["link"] as! NSString;
                                        
                                        self.returnedItemArray[currentIndex].subtitle_url = link
                                        self.returnedItemArray[currentIndex].complete = true
                                        
                                        self.checkSubs()
                                    }
                                }
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
    
    func getSubs(contentArray:Array<VimeoData>) {
        for i in 0 ..< contentArray.count
        {
            var tempVimeoData : VimeoData = contentArray[i];
            let tempVideoID : String = (tempVimeoData.link as NSString).lastPathComponent;
            
            if (tempVimeoData.texttracks_total != 0)
            {
                getSubtitle(videoID: tempVideoID, currentIndex : i);
            } else {
                tempVimeoData.complete = true;
            }
        }
    }
    
    func checkSubs() {
        var tempCheckBool = true;
        
        for i in 0 ..< self.returnedItemArray.count
        {
            if (self.returnedItemArray[i].complete != true)
            {
                tempCheckBool = false;
            }
            
            if (i == self.returnedItemArray.count-1 && tempCheckBool == true){
                createCSV(AlbumID: albumNR, albumName:"", contentArray: self.returnedItemArray);
            }
        }
    }
    
    func createCSV(AlbumID:String, albumName:String, contentArray:Array<VimeoData>) {
        print("creating csv");
        
        let file = AlbumID+"_"+albumName+".csv"
        var text = "AlbumID,"+AlbumID+",Album Name,"+albumName+"\n"
        text.append("ID, Name, URL, Subtitles, duration, Created, Modified, Release\n")
        
        for i in 0 ..< contentArray.count
        {
            let tempVimeoData : VimeoData = contentArray[i];
            let tempVideoID : String = (tempVimeoData.link as NSString).lastPathComponent;
            
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
            
            //reading
//            do {
//                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
//            }
//            catch {/* error handling here */}
        }
    }
    
    @IBAction func RunBtn(_ sender: NSButton) {
        if (self.returnedItemArray.count > 0)
        {
            self.returnedItemArray.removeAll()
        }
        if (self.totalItems > 0)
        {
            self.totalItems = 0.0
        }
        
        let AlbumIDStr = AlbumID.stringValue;
        albumNR = AlbumIDStr;
        
        albumPHPCall(PageNR: 1, AlbumID: AlbumIDStr, perPage: 50, getSubs:true);
        
    }
    
    @IBAction func runWOutSubs(_ sender: NSButton) {
        if (self.returnedItemArray.count > 0)
        {
            self.returnedItemArray.removeAll()
        }
        if (self.totalItems > 0)
        {
            self.totalItems = 0.0
        }
        
        let AlbumIDStr = AlbumID.stringValue;
        albumNR = AlbumIDStr;
        
        albumPHPCall(PageNR: 1, AlbumID: AlbumIDStr, perPage: 50, getSubs:false);
    }
    
    @IBAction func getAlbums(_ sender: NSButton) {
        if (self.returnedItemArray.count > 0)
        {
            self.returnedItemArray.removeAll()
        }
        if (self.totalItems > 0)
        {
            self.totalItems = 0.0
        }
        
        let AlbumIDStr = AlbumID.stringValue;
        albumNR = AlbumIDStr;
        
        allAlbumPHPCall(PageNR: 1, perPage: 100, getSubs:false);
    }
    
    
}
