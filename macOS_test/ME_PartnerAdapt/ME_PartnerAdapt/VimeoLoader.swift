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
	
	let baseURL = URL(string: "https://api.vimeo.com/")!
	
	public init() {
		let oauth = OAuth2CodeGrant(settings: [
			"client_id": "5edd0b79c52ad78769253e99e5746b67ef588f1a",
			"client_secret": "2Pc8yAiga276XlOczyeg8Sb345QmfUs+p4NQLJoiKtMtE16uOR88A/aXkcWPZJ5WYLGJFLrg/g/ZZcRxA6tS4rZk2zPnCuWngCaou8NEP59ToOA4ZiXPu9u1T7kjQgTQ",
            "access_token": "39341f9ff2cd873897f090095d4cab4e",
			"authorize_uri": "https://api.vimeo.com/oauth/authorize",
			"token_uri": "https://api.vimeo.com/oauth/access_token",
			"scope": "private",
			"redirect_uris": ["mevimeoa://oauth/callback"],
			"secret_in_body": true,
			"verbose": true,
		])
		super.init(oauth2: oauth)
	}
	
	
	/** Perform a request against the Vimeo API and return decoded JSON or an NSError. */
	func request(path: String, callback: @escaping ((OAuth2JSON?, Error?) -> Void)) {
		oauth2.logger = OAuth2DebugLogger(.trace)
		let url = baseURL.appendingPathComponent(path)
		let req = oauth2.request(forURL: url)
		
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
    
    func requestUserdata(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "me", callback: callback)
    }
    
    func requestUserAlbumData(callback: @escaping ((_ dict: OAuth2JSON?, _ error: Error?) -> Void)) {
        request(path: "me/albums/", callback: callback)
    }
}

