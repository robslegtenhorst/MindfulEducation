'use strict'

/**
 *Copyright 2013 Vimeo
 *
 *Licensed under the Apache License, Version 2.0 (the "License");
 *you may not use this file except in compliance with the License.
 *You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 *Unless required by applicable law or agreed to in writing, software
 *distributed under the License is distributed on an "AS IS" BASIS,
 *WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *See the License for the specific language governing permissions and
 *limitations under the License.
 */

//Usage :: node ./me_GetVideoInfo.js inputCSV OutputDir
//input CSV is a csv with all vimeo ID's
//output dir will contain info files per videos
//output csv table = name,modified_time,src download url

var fs = require('fs');
var parse = require('csv-parse');
var async = require('async');

var Vimeo = require('../index').Vimeo
var util = require('util')

var inputFile= process.argv[2]

var outputDir= process.argv[3]

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

// Here we have to build the vimeo library using the `client_id`, `client_secret` and an
// `access_token`.
//
// For the request we make below (/channels) the access token can be a client access token instead
// of a user access token.
var lib = new Vimeo(config.client_id, config.client_secret)

if (config.access_token) {
	lib.setAccessToken(config.access_token)
	
	var parser = parse({delimiter: ','}, function (err, data) {
		var promises = []
		for(var i = 0; i < data.length; i++) {
			promises.push(makeRequest(lib,data[i][0]))
		}
		
		Promise.all(promises).then((data) => {
												//console.log('completed',data)
												var csvString = "name,modified_time,src download url, text tracks\n"
												for(var j = 0; j < data.length; j++) {
													csvString = csvString + data[j]
												}
												
												
												fs.writeFile(outputDir+"/all.csv", csvString, function(err) {
													if(err) {
														return console.log(err);
													}
													
													console.log("The file was saved!");
												});
											});
	});
	fs.createReadStream(inputFile).pipe(parser);
	
} else {
	// Unauthenticated API requests must request an access token. You should not request a new access
	// token for each request, you should request an access token once and use it over and over.
	lib.generateClientCredentials('public', function (err, response) {
		if (err) {
			throw err
		}
		
								// Assign the access token to the library.
								lib.setAccessToken(response.access_token)
								makeRequest(lib)
							})
}

function makeRequest (lib, videoID) {
	// Make an API request
	return new Promise((resolve, reject) => {
		lib.request({
								// This is the path for the videos contained within the staff picks channels
								method: 'GET',
								path: 'videos/'+videoID+'?fields=name,created_time,modified_time,release_time,download,metadata',
								query: {
									name: videoID
								}
							}, function (error, body, statusCode, headers) {
								if (error) {
									console.log('error')
									console.log(error)
									reject(error)
								} else {
									var headersJSON = JSON.stringify(headers, null, 4)
									var headersJSONContent = JSON.parse(headersJSON);
									body['xRatelimitRemaining'] = headersJSONContent['x-ratelimit-remaining']
									body['statusCode'] = statusCode
									
									console.log('xRatelimitRemaining', body['xRatelimitRemaining'])
									
									var csvString = body['name'] + ',' + body['modified_time']
									var srcLink = ","
									
									for(var i = 0; i < body['download'].length; i++) {
										if (body['download'][i].quality == "source") {
											srcLink = srcLink + body['download'][i].link
										}
									}
									
									if (srcLink == ","){
										srcLink = srcLink + "none"
									}
									
									
									csvString = csvString + srcLink
									
									if (body['metadata']['connections']['texttracks'].total > 0) {
										lib.request({
											method: 'GET',
											path: 'videos/'+videoID+'/texttracks?fields=name,language,link,active',
											query: {
												name:videoID
											}
										}, function (error, body, statuscode, headers) {
											if (error) {
												console.log('error')
												console.log(error)
												reject(error)
											} else {
												for(var k = 0; k < body.total; k++) {
													if (body['data'][k].active == true){
														csvString = csvString + ", " + body['data'][k].language + ", " + body['data'][k].link
													}
												}
												
												resolve(csvString + '\n')
											}
											
										})
									} else {
										resolve(csvString + '\n')
									}
								}
							})
	})
}

function makeTTRequest (lib, videoID) {
	
}
