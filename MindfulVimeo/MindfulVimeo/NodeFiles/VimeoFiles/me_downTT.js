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

//Usage :: node ./me_GetVideoInfo.js inputCSV OutputDir
//input CSV is a csv with all vimeo ID's
//output dir will contain info files per videos
//output csv table = name,modified_time,src download url

var https = require('https');
var fs = require('fs');
var parse = require('csv-parse');

var inputCSV= process.argv[2]
var outputDir= process.argv[3]

var parser = parse({delimiter: ','}, function (err, data) {
	console.log("err",err)
	var promises = []
	for(var i = 0; i < data.length; i++) {
		if (data[i][0] != "name"){
			if (data[i][3] != "" && data[i][3] != " " && data[i][3] != undefined) promises.push(getFile(data[i][0],data[i][3],data[i][4]))
			if (data[i][5] != "" && data[i][5] != " " && data[i][5] != undefined) promises.push(getFile(data[i][0],data[i][5],data[i][6]))
		}
	}

	Promise.all(promises).then((data) => {
		console.log('completed',data)
	});
})

// console.log('inputCSV',fs.createReadStream(inputCSV).pipe(process.stdout))

function getFile (name,lang,url) {
	console.log("name",name,"lang",lang,"url",url)
	return new Promise((resolve, reject) => {
		var dest = outputDir+"/"+name+"_"+lang+".vtt"
		var file = fs.createWriteStream(dest);
		var request = https.get(url, function(response) {
			response.pipe(file);
			file.on('finish', function() {
				file.close();  // close() is async, call cb after close completes.
				resolve()
			});
		}).on('error', function(err) { // Handle errors
			fs.unlink(dest); // Delete the file async. (But we don't check the result)
			reject(error)
		});
	})
}

fs.createReadStream(inputCSV).pipe(parser);
