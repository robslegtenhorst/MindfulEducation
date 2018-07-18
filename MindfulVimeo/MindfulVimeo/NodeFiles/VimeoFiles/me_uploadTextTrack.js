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


var texttrack_file = process.argv[2]
var texttrack_lang = process.argv[3]

var texttrack_uri = '/videos/280379198/texttracks'
//var texttrack_uri = '/videos/280380363/texttracks/5696946'


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

client.request({
               method: 'POST',
               path: texttrack_uri,
               query: {
               type: 'subtitles',
               language: 'en-GB',
               name: "test",
               active: true
               }
               }, function (error, body, statusCode, headers) {
               if (error) {
               console.log('There was an error making the request.')
               console.log('Server reported: ' + error)
               return
               }
               
               console.log('body:: ')
               console.log(JSON.stringify(body, null, 2));
               console.log('body.uri:: ')
               console.log(body.uri)
               
               var stat = fs.statSync(texttrack_file);
               var options_2 = {
               method: 'PUT',
               headers: {
               'content-Length': stat.size
               }
               };
               
               client.request({
                              method: 'PUT',
                              path: body.uri,
                              body: fs.createReadStream(texttrack_file)
                              }, function (error, body, statusCode, headers) {
                              if (error) {
                              console.log('There was an error making the request.')
                              console.log('Server reported: ' + error)
                              console.log('body 1:: ')
                              console.log(body)
                              console.log('statusCode 1:: ')
                              console.log(statusCode)
                              console.log('headers 1:: ')
                              console.log(headers)
                              return
                              }
                              })
               
               
               })
               






