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
	
	public init() {
		let oauth = OAuth2CodeGrant(settings: [
			"client_id": "69c02b9db167089acfdd426f54a95aea59abafbd",
			"client_secret": "L7AhuXemGMEUAcQbWqcNVb0LBFL+MFjw1qPonz669aVQGxpKMCDH/0fU+UkLbeHp8n+RjOHcQM+F6M/CDp7J8hpqpQr84KCbjL+72y6AqqSDQW8+Uu/BAoKZ11gLrxMY",
            "access_token": "e6e0acc1b5572eb15ee046427888b18d",
			"authorize_uri": "https://api.vimeo.com/oauth/authorize",
			"token_uri": "https://api.vimeo.com/oauth/access_token",
			"scope": "private",
			"redirect_uris": ["mevimeoapp2://oauth/callback"],
			"secret_in_body": true,
			"verbose": true,
		])
		super.init(oauth2: oauth)
	}
	
	
	/** Perform a request against the Vimeo API and return decoded JSON or an NSError. */
    func request(path: String, query: String, callback: @escaping ((OAuth2JSON?, Error?) -> Void)) {
		oauth2.logger = OAuth2DebugLogger(.trace)
//        oauth2.authConfig.authorizeEmbedded = true
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.query = query
        
        let url = URL(string: (urlComponents?.string)!);
		let req = oauth2.request(forURL: url!)
		
		perform(request: req) { response in
			do {
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
        oauth2.logger = OAuth2DebugLogger(.trace)
        print("req init")
        request(path: "/me", query: "", callback: callback)
    }
    
    func requestUserdata(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        print("req user 2")
        request(path: "/me", query: "fields=link,name,pictures", callback: callback)
    }
    
    func requestAlbumTotal(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "/me/albums", query: "per_page=1&fields=uri", callback: callback)
    }
    
    func requestVideoTotal(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "/me/videos", query: "per_page=1&fields=uri", callback: callback)
    }
    
    func requestUserAlbumData(page: CGFloat, callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "/me/albums", query: "page="+page.description+"&per_page="+VimeoData().maxItems.description+"&sort=alphabetical&fields=uri,name,link,duration,created_time,modified_time", callback: callback)
    }
}

