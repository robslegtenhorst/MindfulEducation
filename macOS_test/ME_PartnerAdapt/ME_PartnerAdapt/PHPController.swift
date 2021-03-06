//
//  PHPController.swift
//  ME_PartnerAdapt
//
//  Created by Rob Slegtenhorst on 17/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import Alamofire

class PHPController: NSViewController {
	
	@IBOutlet weak var AlbumID: NSTextField!
	@IBOutlet weak var ProjID: NSTextField!
    
    var totalItems:Double = 0.0;
    var repeatPages:Double = 0.0
	var albumNR:String = ""
	var projNR:String = ""
	
	var group_name:String=""
	var project_name:String=""
    
    var tempReturnedItemArray:Array<VimeoData> = [];
    
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
        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/vimeo_album.php?page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=uri,name")!
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
    
    func subTextPHPCall(VideoID:String, AlbumID:String, VideoName:String) {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/sub.php?video="+VideoID.description)!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let session = URLSession.shared
        
        var tempReturnedItemArray:Array<VimeoSubData> = [];
        
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
                                    
                                    for i in 0 ..< dataArr.count
                                    {
                                        
                                        let dataDic = dataArr[i] as! NSDictionary;
                                        let name = dataDic["name"] as! NSString;
                                        let link = dataDic["link"] as! String;
                                        let hls_link = dataDic["hls_link"] as! String;
                                        let language = dataDic["language"] as! NSString;
                                        
                                        let lowercaseVideoName = (VideoName as String).lowercased()
                                        
                                        let url = link
                                        
                                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                                        let data1Path = documentsDirectory.appendingPathComponent(AlbumID as String)
                                        let dataPath = data1Path.appendingPathComponent((VideoName as String))
//                                        dataPath = data1Path.appendingPathComponent((VideoName as String)+"/VTT/")
                                        
                                        var filePath:URL
                                        
                                        if name.lowercased.contains(".vtt") {
                                            print("found")
                                            // Enable to download with filename as stored on Vimeo
                                            // filePath = dataPath.appendingPathComponent(name as String)
                                            // Enable to download with same filename as video
                                            filePath = dataPath.appendingPathComponent(lowercaseVideoName+"."+(language as String)+".vtt")
                                        } else {
                                            print("not found")
                                            // Enable to download with filename as stored on Vimeo
                                            // filePath = dataPath.appendingPathComponent((name as String)+".vtt")
                                            // Enable to download with same filename as video
                                            filePath = dataPath.appendingPathComponent(lowercaseVideoName+"."+(language as String)+".vtt")
                                        }
                                        
                                        print(url)
                                        print("--------------")
                                        
                                        do {
                                            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
                                        } catch let error as NSError {
                                            print("Error creating directory: \(error.localizedDescription)")
                                        }
                                        
                                        Alamofire.download(url, method: .get, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
                                            return (filePath, [.removePreviousFile, .createIntermediateDirectories])
                                        })
                                            .downloadProgress { progress in
                                                print("Download Progress: \(progress.fractionCompleted)")
                                            }
                                            .responseData { response in
                                                print(response)
                                        }
                                        
                                        
                                        let itemData = VimeoSubData(dataDic:dataDic, name:name, link:link, language:language, hls_link:hls_link, videoName:VideoName);
                                        
                                        tempReturnedItemArray.append(itemData);
                                        
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
    
    func posterCall(PageNR:Double, AlbumID:String, perPage:Double) {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/index.php?album="+AlbumID+"&page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=uri")!
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
                            if (dictionary["headers"] as? [String: Any]) != nil
                            {
//                                print(dictionary["headers"])
                            }
                            if let bodyDictionary = dictionary["body"] as? [String: Any]
                            {
                                if let dataArr = bodyDictionary["data"] as? NSArray
                                {
                                    //                                    print(dataArr)
                                    
                                    for i in 0 ..< dataArr.count
                                    {
                                        let dataDic = dataArr[i] as! NSDictionary;
                                        let videoURI = dataDic["uri"] as! String;
                                        let pictURI = videoURI+"/pictures";
                                        
                                        print(pictURI);
                                        
                                        let filePath = "/usr/bin/php";
                                        let path = filePath;

                                        let arguments = ["/Applications/XAMPP/xamppfiles/htdocs/vimeo/example/setPosterFrame.php", pictURI];

                                        let task = Process.launchedProcess(launchPath: path, arguments: arguments );
                                        task.waitUntilExit();
                                    }
                                }
                                
                                
                                
                                
                                
//                                print("button clicked, fingers crossed")
                                
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
    
    func albumPHPCall(PageNR:Double, AlbumID:String, perPage:Double, getSubs:Bool, albumName:NSString = "", getVids:Bool = true) {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/index.php?album="+AlbumID+"&page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=link,name,metadata,duration,created_time,modified_time,release_time,download")!
        //        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/index.php?album=4595765&page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=link,name,metadata,duration,created_time,modified_time,release_time,download")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let session = URLSession.shared
        
        self.tempReturnedItemArray = [];
        
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
                                        let texttracks_uri = texttracks["uri"] as! NSString;
                                        
                                        var downloadLink = "";
                                        var videoType = "";
                                        
                                        let downloadArray = dataDic["download"] as! NSArray;
                                        
                                        for j in 0 ..< downloadArray.count
                                        {
                                            let downloadDataDic = downloadArray[j] as! NSDictionary;
                                            let quality = downloadDataDic["quality"] as! NSString;
                                            let height = downloadDataDic["height"] as! NSNumber;
                                            
                                            if(quality == "source") {
                                                downloadLink = (downloadDataDic["link"] as! NSString) as String;
                                                videoType = "SRC"
                                            } else if(quality == "hd" && height == 1080 && downloadLink == "") {
                                                downloadLink = (downloadDataDic["link"] as! NSString) as String;
                                                videoType = "HD"
                                            }
                                            
                                        }
                                        
                                        //                                        self.downloadFile(url:downloadLink, folderName:AlbumID,subFolder:"SRC", fileName:name as String, fileExtension:".mp4")
                                        
                                        self.subTextPHPCall(VideoID:texttracks_uri as String, AlbumID: AlbumID, VideoName: name as String)
                                        
                                        let itemData = VimeoData(dataDic:dataDic, name:name, link:link, texttracks_total:texttracks_total, duration:duration, created_time:created_time, modified_time:modified_time, release_time:release_time, subtitle_url:"FUNC DISABLED", downloadLink: downloadLink as NSString, albumID: AlbumID as NSString, videoType: videoType, complete:false);
                                        
                                        //ENABLE FOR PAGING
                                        //                                        self.returnedItemArray.append(itemData);
                                        
                                        self.tempReturnedItemArray.append(itemData);
                                        
                                    }
                                    
                                }
                            }
                            
                            if (PageNR >= self.repeatPages)
                            {
                                if (getVids){ self.startDownload() }
                                if (getSubs){
                                    self.getSubs(contentArray: self.tempReturnedItemArray)
                                } else {
                                    //ENABLE FOR PAGING
                                    //                                    self.createCSV(AlbumID:AlbumID, contentArray: self.returnedItemArray);
                                    self.createCSV(AlbumID:AlbumID, albumName:albumName as String, contentArray: self.tempReturnedItemArray);
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
    
	func albumCSVPHPCall(PageNR:Double, AlbumID:String, perPage:Double, getSubs:Bool, albumName:NSString = "") {
		let url: NSURL = NSURL(string: "http://localhost/vimeo/example/index.php?album="+AlbumID+"&page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=link,name,metadata,duration,created_time,modified_time,release_time,download")!
		let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
		let session = URLSession.shared
		
		print("url :: "+url.absoluteString!)
		
		self.tempReturnedItemArray = [];
		
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
										let texttracks_uri = texttracks["uri"] as! NSString;
										
										var downloadLink = "";
										var videoType = "";
										
										let downloadArray = dataDic["download"] as! NSArray;
										
										for j in 0 ..< downloadArray.count
										{
											let downloadDataDic = downloadArray[j] as! NSDictionary;
											let quality = downloadDataDic["quality"] as! NSString;
											let height = downloadDataDic["height"] as! NSNumber;
											
											if(quality == "source") {
												downloadLink = (downloadDataDic["link"] as! NSString) as String;
												videoType = "SRC"
											} else if(quality == "hd" && height == 1080 && downloadLink == "") {
												downloadLink = (downloadDataDic["link"] as! NSString) as String;
												videoType = "HD"
											}
											
										}
										
										self.subTextPHPCall(VideoID:texttracks_uri as String, AlbumID: AlbumID, VideoName: name as String)
										
										let itemData = VimeoData(dataDic:dataDic, name:name, link:link, texttracks_total:texttracks_total, duration:duration, created_time:created_time, modified_time:modified_time, release_time:release_time, subtitle_url:"FUNC DISABLED", downloadLink: downloadLink as NSString, albumID: AlbumID as NSString, videoType: videoType, complete:false);
										
										self.tempReturnedItemArray.append(itemData);
										
									}
									
								}
							}
							
							if (PageNR >= self.repeatPages)
							{
								if (getSubs){
									self.getSubs(contentArray: self.tempReturnedItemArray)
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
	
	func projCSVPHPCall(PageNR:Double, ProjID:String, perPage:Double, getSubs:Bool, albumName:NSString = "") {
		let url: NSURL = NSURL(string: "http://localhost/vimeo/example/indexProj.php?project="+ProjID+"&page="+PageNR.description+"&maxReturned="+perPage.description+"&fields=link,name,metadata,duration,created_time,modified_time,release_time,download")!
		let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
		let session = URLSession.shared
		
		print("url :: "+url.absoluteString!)
		
		self.tempReturnedItemArray = [];
		
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
						print("status", status)
						
						if (status == 200)
						{
							if (dictionary["headers"] as? [String: Any]) != nil
							{
//								print(headersDictionary)
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
										print("repeatPages", self.repeatPages);
									}
								}
								
								// contains total, per page & page nr
								
								if let dataArr = bodyDictionary["data"] as? NSArray
								{
									
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
										let texttracks_uri = texttracks["uri"] as! NSString;
										
										var downloadLink = "";
										var videoType = "";
										
										let downloadArray = dataDic["download"] as! NSArray;
										
										for j in 0 ..< downloadArray.count
										{
											let downloadDataDic = downloadArray[j] as! NSDictionary;
											let quality = downloadDataDic["quality"] as! NSString;
											let height = downloadDataDic["height"] as! NSNumber;
											
											if(quality == "source") {
												downloadLink = (downloadDataDic["link"] as! NSString) as String;
												videoType = "SRC"
											} else if(quality == "hd" && height == 1080 && downloadLink == "") {
												downloadLink = (downloadDataDic["link"] as! NSString) as String;
												videoType = "HD"
											}
											
										}
										
//										self.subTextPHPCall(VideoID:texttracks_uri as String, AlbumID: ProjID, VideoName: name as String)
										
										let itemData = VimeoData(dataDic:dataDic, name:name, link:link, texttracks_total:texttracks_total, duration:duration, created_time:created_time, modified_time:modified_time, release_time:release_time, subtitle_url:"FUNC DISABLED", downloadLink: downloadLink as NSString, albumID: ProjID as NSString, videoType: videoType, complete:false);
										
										self.tempReturnedItemArray.append(itemData);
										
									}
									
								}
							}
							
							if (PageNR >= self.repeatPages)
							{
								if (getSubs){
									self.getSubs(contentArray: self.tempReturnedItemArray)
								} else {
									//ENABLE FOR PAGING
									//                                    self.createCSV(AlbumID:AlbumID, contentArray: self.returnedItemArray);
									self.createProjectCSV(ProjID:ProjID, projectName:albumName as String, contentArray: self.tempReturnedItemArray);
								}
								
							} else {
								let nextPageNR = PageNR + 1;
								self.projCSVPHPCall(PageNR: nextPageNR, ProjID: ProjID, perPage: perPage, getSubs:getSubs);
							}
						} else {
							print("Content returned error for Project call :: "+status.description);
						}
					}
					
				}catch {
					print("Error with Json: \(error)")
				}
				
			}
		}
		
		task.resume();
	}
	
    
    func startDownload() -> Void {
        let itemData: VimeoData = self.tempReturnedItemArray[0]
        self.downloadFile(url:itemData.downloadLink as String, folderName:itemData.albumID as String, subFolder:itemData.videoType, fileName:itemData.name as String, fileExtension:".mp4")
    }
    
    func downloadFile(url:String, folderName:String, subFolder:String, fileName:String, fileExtension:String) -> Void {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let data1Path = documentsDirectory.appendingPathComponent(folderName as String)
        let dataPath = data1Path.appendingPathComponent((fileName as String)+"/"+subFolder+"/")
        
        var filePath:URL
        
        if fileName.lowercased().contains(fileExtension) {
            print("found")
            filePath = dataPath.appendingPathComponent(fileName as String)
        } else {
            print("not found")
            filePath = dataPath.appendingPathComponent((fileName as String)+fileExtension)
        }
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        
        Alamofire.download(url, method: .get, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            return (filePath, [.removePreviousFile, .createIntermediateDirectories])
        })
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                print(response)
            }.response(completionHandler: { (DefaultDownloadResponse) in
                
                self.tempReturnedItemArray.removeFirst()
                if DefaultDownloadResponse.response?.statusCode == 200 {
                    
                    if !self.tempReturnedItemArray.isEmpty{
                        self.startDownload()
                    }
                }
                
            })
    }
    
    func getSubtitle(videoID:String, currentIndex : NSInteger) {
        let url: NSURL = NSURL(string: "http://localhost/vimeo/example/vimeo_subtitle.php?video="+videoID)!
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
	
	func getGroupNameCall(albumID:String, albumName:String, contentArray:Array<VimeoData>) -> Void {
		let url: NSURL = NSURL(string: "http://localhost/vimeo/example/getGroupName.php?albumID="+albumID)!
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
							if (dictionary["headers"] as? [String: Any]) != nil
							{
								//print(headersDictionary)
							}
							
							if let bodyDictionary = dictionary["body"] as? [String: Any]
							{
								self.group_name = bodyDictionary["name"] as! String
								print("received album_name :: "+self.group_name)
								self.createCSV(AlbumID:albumID, albumName:self.group_name, contentArray:contentArray)
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
		
		//        createCSV(AlbumID:albumID, albumName:self.group_name, contentArray:contentArray)
	}
	
	func getProjectNameCall(projectID:String, projectName:String, contentArray:Array<VimeoData>) -> Void {
		let url: NSURL = NSURL(string: "http://localhost/vimeo/example/getProjectName.php?projectID="+projectID)!
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
							if (dictionary["headers"] as? [String: Any]) != nil
							{
								//print(headersDictionary)
							}
							
							if let bodyDictionary = dictionary["body"] as? [String: Any]
							{
								self.project_name = bodyDictionary["name"] as! String
								print("received album_name :: "+self.project_name)
								self.createProjectCSV(ProjID:projectID, projectName:self.project_name, contentArray:contentArray)
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
		
		//        createCSV(AlbumID:albumID, albumName:self.group_name, contentArray:contentArray)
	}
    
	func createCSV(AlbumID:String, albumName:String, contentArray:Array<VimeoData>) {
		
		var newAlbumName = albumName
		
		if (newAlbumName == "") {
			getGroupNameCall(albumID: AlbumID, albumName:albumName, contentArray:contentArray)
			newAlbumName = self.group_name
		} else {
			
			print("creating csv");
			
			let file = AlbumID+"_"+newAlbumName+".csv"
			var text = "AlbumID,"+AlbumID+",Album Name,"+newAlbumName+"\n"
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
	}
	
	func createProjectCSV(ProjID:String, projectName:String, contentArray:Array<VimeoData>) {
		
		var newProjectName = projectName
		
		if (newProjectName == "") {
			getProjectNameCall(projectID: ProjID, projectName:projectName, contentArray:contentArray)
			newProjectName = self.project_name
		} else {
			
			print("creating csv");
			
			let file = ProjID+"_"+newProjectName+".csv"
			var text = "AlbumID,"+ProjID+",Album Name,"+newProjectName+"\n"
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
    
    
    @IBAction func DownloadSubs(_ sender: NSButton) {
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
        
        albumPHPCall(PageNR: 1, AlbumID: AlbumIDStr, perPage: 50, getSubs:true, albumName: "", getVids: false);
    }
    
    @IBAction func setPosterFrame(_ sender: NSButton) {
        let AlbumIDStr = AlbumID.stringValue;
        albumNR = AlbumIDStr;
        
        posterCall(PageNR: 1, AlbumID: AlbumIDStr, perPage: 50);
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
	
	@IBAction func run_CSV(_ sender: Any) {
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
		
		albumCSVPHPCall(PageNR: 1, AlbumID: AlbumIDStr, perPage: 50, getSubs:false);
		
	}
	
	@IBAction func run_projCSV(_ sender: Any) {
		if (self.returnedItemArray.count > 0)
		{
			self.returnedItemArray.removeAll()
		}
		if (self.totalItems > 0)
		{
			self.totalItems = 0.0
		}
		
		projNR = ProjID.stringValue;
		
		projCSVPHPCall(PageNR: 1, ProjID: ProjID.stringValue, perPage: 100, getSubs:false);
		
	}
    
}
