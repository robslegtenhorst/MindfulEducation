//
//  VimeoLoaderLoader.swift
//  OAuth2App
//
//  Created by Pascal Pfiffner on 11/12/14.
//  CC0, Public Domain
//

import Foundation
import OAuth2


/**
	Simple class handling authorization and data requests with Vimeo.
 */
class VimeoLoader: OAuth2DataLoader, DataLoader {
    
//    let baseURL = URL(string: "https://api.vimeo.com/")!
    
    let baseURL : String = "https://api.vimeo.com/"
	
	var enableHeaders : Bool = true
	
	public init() {
		let oauth = OAuth2CodeGrant(settings: [
			"client_id": "5edd0b79c52ad78769253e99e5746b67ef588f1a",
			"client_secret": "2Pc8yAiga276XlOczyeg8Sb345QmfUs+p4NQLJoiKtMtE16uOR88A/aXkcWPZJ5WYLGJFLrg/g/ZZcRxA6tS4rZk2zPnCuWngCaou8NEP59ToOA4ZiXPu9u1T7kjQgTQ",
            "access_token": "c3f85018752dda44fb6db6704d6f9bcb",
			"authorize_uri": "https://api.vimeo.com/oauth/authorize",
			"token_uri": "https://api.vimeo.com/oauth/access_token",
			"scope": "public private purchased create edit delete interact upload",
			"redirect_uris": ["mevimeoapp://oauth/callback"],
			"secret_in_body": true,
			"verbose": true,
		])
		super.init(oauth2: oauth)
	}
	
	
	/** Perform a request against the Vimeo API and return decoded JSON or an NSError. */
    func request(path: String, query: String, callback: @escaping ((OAuth2JSON?, Error?) -> Void)) {
//		oauth2.logger = OAuth2DebugLogger(.trace)
//      oauth2.authConfig.authorizeEmbedded = true
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.query = query
        
        let url = URL(string: (urlComponents?.string)!);
		let req = oauth2.request(forURL: url!)
		
		perform(request: req) { response in
			do {
				let stringNumber = response.response.allHeaderFields["X-RateLimit-Remaining"] as! String
				let numberFromString = Int(stringNumber)
				
				if(numberFromString! <= 40) {
					print("X-RateLimit-Remaining :: " + (response.response.allHeaderFields["X-RateLimit-Remaining"] as! String))
				}
				if(self.enableHeaders){
					print("*********")
					print("X-RateLimit-Limit :: " + (response.response.allHeaderFields["X-RateLimit-Limit"] as! String))
					print("X-RateLimit-Remaining :: " + (response.response.allHeaderFields["X-RateLimit-Remaining"] as! String))
					print("X-RateLimit-Reset :: " + (response.response.allHeaderFields["X-RateLimit-Reset"] as! String))
					print("Status Code :: " + (response.response.statusCode.description))
				}
				
				let dict = try response.responseJSON()
				DispatchQueue.main.async() {
					callback(dict, nil)
				}
			}
			catch let error {
				DispatchQueue.main.async() {
					callback(nil, error)
				}
			}
		}
    }
    
    func requestInit(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
//        oauth2.logger = OAuth2DebugLogger(.trace)
        request(path: "/me", query: "", callback: callback)
    }
    
    func requestUserdata(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "/me", query: "fields=link,name,pictures,uri,resource_key", callback: callback)
    }
    
    func requestAlbumTotal(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "/me/albums", query: "per_page=1&fields=uri", callback: callback)
    }
    
    func requestVideoTotal(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "/me/videos", query: "per_page=1&fields=uri", callback: callback)
    }
    
    func requestUserAlbumData(page: CGFloat, callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "/me/albums", query: "page="+page.description+"&per_page="+VimeoData().maxItems.description+"&sort=alphabetical&fields=uri,name,link,duration,created_time,modified_time&sort=modified_time", callback: callback)
    }
    
    func requestVideoData(page: CGFloat, callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        let queryStr = "page="+page.description+"&per_page="+VimeoData().tempMaxItems.description+"&fields=uri,name,link,duration,width,height,created_time,modified_time,release_time,metadata,pictures,status,stats,download&sort=modified_time"
        request(path: "/me/videos", query: queryStr, callback: callback)
	}
	
	func requestSub(uri: NSString, callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
		request(path: uri as String, query: "", callback: callback)
	}
}

