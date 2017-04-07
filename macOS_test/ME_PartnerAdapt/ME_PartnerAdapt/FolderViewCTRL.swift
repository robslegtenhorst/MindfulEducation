//
//  FolderViewCTRL.swift
//  ME_PartnerAdapt
//
//  Created by Rob Slegtenhorst on 14/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa

class FolderViewCTRL: NSViewController, XMLParserDelegate {
    
    @IBOutlet weak var textfield: NSTextField!
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var url1 = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlpath = Bundle.main.path(forResource: "urls", ofType: "xml")
        let url = NSURL.fileURL(withPath: urlpath!)
        
        beginParsing(url: url);
        
        //textfield.stringValue = posts.description;
        textfield.stringValue = posts.count.description; //322 items
        
        // TODO Feed post items to shell script
        // youtube-dl -u michael@mindful-education.co.uk -v --all-subs https://vimeo.com/202908729

        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func runCMD(url : String){
        
        do {
            
            let filePath = Bundle.main.path(forResource: "youtube-dl", ofType: "");
            
            let path = filePath;
            let arguments = ["-u", "michael@mindful-education.co.uk", "-p", "W@RViYk&$rj3", "-w", "-o", "~/tmp/Vimeo_bk/%(title)s.%(ext)s", "--all-subs", url];
            
            let task = Process.launchedProcess(launchPath: path!, arguments: arguments );
            task.waitUntilExit();
            
        }
        
    }
    
    func beginParsing(url:URL)
    {
        posts = []
        parser = XMLParser(contentsOf:url)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        
        
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "url")
        {
            //print("parser :: didStartElement :: "+elementName)
            elements = NSMutableDictionary()
            elements = [:]
            url1 = NSMutableString()
            url1 = ""
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        
        
        if (elementName as NSString).isEqual(to: "url") {
            if !url1.isEqual(nil) {
                //print("parser :: didEndElement :: "+elementName)
                element = "";
                elements.setObject(url1, forKey: "url" as NSCopying)
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        
        if element.isEqual(to: "url") {
            //print("parser :: foundCharacters :: "+string)
            posts.add(string)
        }
        
    }
    
    func tempRun(){
        for i in 0 ..< posts.count  {
            let url = posts[i] as! String;
            runCMD(url : url)
        }
    }
    
    @IBAction func runCMD(_ sender: NSButton) {
        tempRun()
    }
}
