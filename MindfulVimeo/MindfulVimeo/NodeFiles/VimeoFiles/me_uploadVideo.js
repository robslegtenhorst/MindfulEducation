'use strict'

/**
 *   Copyright 2013 Vimeo
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */

var Vimeo = require('../index').Vimeo

var fs = require('fs')
var request = require('request');


var contentType = 'application/octet-stream';


var album_uri = process.argv[2]

var video_file = process.argv[3]
var video_name = process.argv[4]

var texttrack_amount = process.argv[5]

var texttrack_array = []

if (texttrack_amount != 0)
{
    for(var i = 0; i < texttrack_amount-1;i++){
        var currentIndex = 4 + (2 * ( i + 1 ));
        
        var currentPathVal = process.argv[currentIndex];
        var currentLocaleVal = process.argv[currentIndex+1];
        
        texttrack_array.push([currentPathVal,currentLocaleVal])
//        console.log('index :: '+currentIndex+' -- path :: '+texttrack_array[i][0]+' -- locale :: '+texttrack_array[i][1]+'\n')
    }
}


try {
    var config = require('./config.json')
} catch (error) {
    console.error('ERROR: For this example to run properly you must create an API app at ' +
                  'https://developer.vimeo.com/apps/new and set your callback url to ' +
                  '`http://localhost:8080/oauth_callback`.')
    console.error('ERROR: Once you have your app, make a copy of `config.json.example` named ' +
                  '`config.json` and add your client ID, client secret and access token.')
    process.exit()
}

if (!config.access_token) {
    throw new Error('You can not upload a video without configuring an access token.')
}

// Instantiate the library with your client id, secret and access token (pulled from dev site)
var client = new Vimeo(config.client_id, config.client_secret, config.access_token)

var params = {
    'name': video_name,
    'description': "This video was uploaded through the Vimeo API's NodeJS SDK."
}

var returnedJSON = {}

// This works, but doesn't upload to specific album, or adds subtitles

client.upload(
              video_file,
              params,
              function (uri) {
              // Get the metadata response from the upload and log out the Vimeo.com url
              client.request(uri + '?fields=link,metadata.connections.texttracks', function (error, body, statusCode, headers) {
                             if (error) {
                             console.log('There was an error making the request.')
                             console.log('Server reported: ' + error)
                             return
                             }
                             var headersJSON = JSON.stringify(headers, null, 4)
                             var headersJSONContent = JSON.parse(headersJSON);
                             body['xRatelimitRemaining'] = headersJSONContent['x-ratelimit-remaining']
                             body['statusCode'] = statusCode
                             returnedJSON['xRatelimitRemaining'] = headersJSONContent['x-ratelimit-remaining']
                             returnedJSON['statusCode'] = statusCode
                             returnedJSON['link'] = body['link']
                             returnedJSON['uri'] = body['metadata']['connections']['texttracks']['uri']
                             returnedJSON['videoUri'] = uri
                             console.log(JSON.stringify(returnedJSON, null, 4))
                             
                             })
              },
              function (bytesUploaded, bytesTotal) {
              var percentage = (bytesUploaded / bytesTotal * 100).toFixed(2)
//              below can be used as a progressbar
//              console.log(bytesUploaded, bytesTotal, percentage + '%')
              },
              function (error) {
              console.log('Failed because: ' + error)
              }
              )

