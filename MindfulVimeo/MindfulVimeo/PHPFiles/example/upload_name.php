<?php

use Vimeo\Vimeo;
use Vimeo\Exceptions\VimeoUploadException;

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

$config = require(__DIR__ . '/init.php');

if (empty($config['access_token'])) {
    throw new Exception('You can not upload a file without an access token. You can find this token on your app page, or generate one using auth.php');
}

$lib = new Vimeo($config['client_id'], $config['client_secret'], $config['access_token']);

//  Get the args from the command line to see what files to upload.


//  Send the files to the upload script.
//  Update progress.
    // Create album to add video to
    $album_args = array('name' => 'test_group');
    $albumReq = $lib->request('/me/albums', $album_args, 'POST');
    
    print $albumReq['body']['uri'];
    
    if ($albumReq['status'] != 201) {
        foreach ($albumReq as $item) {
            echo $item;
        }
        throw new Exception('change name failed' .$albumReq);
    }
    
