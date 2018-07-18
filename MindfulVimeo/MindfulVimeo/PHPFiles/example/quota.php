<?php

use Vimeo\Vimeo;

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

$lib = new Vimeo($config['client_id'], $config['client_secret'], $config['access_token']);
    
$uri = '/me/';
$video_args = array('fields' => ['uri,name']);
$video_data = $lib->request($uri,$video_args);

    if($video_data['status'] == 200) {
//        print "X-RateLimit-Limit :: ".$video_data['headers']['X-RateLimit-Limit']."\n";
//        print "X-RateLimit-Remaining :: ".$video_data['headers']['X-RateLimit-Remaining']."\n";
//        print "X-RateLimit-Reset :: ".$video_data['headers']['X-RateLimit-Reset']."\n";
//
//        print "upload_quota free :: ".$video_data['body']['upload_quota']['space']['free']."\n";
//        print "upload_quota max :: ".$video_data['body']['upload_quota']['space']['max']."\n";
//        print "upload_quota used :: ".$video_data['body']['upload_quota']['space']['used']."\n";
//
//        print "upload_quota used :: ".$video_data['body']['upload_quota']['quota']['hd']."\n";
//        print "upload_quota used :: ".$video_data['body']['upload_quota']['quota']['sd']."\n";
        
        //$link = $video_data['body']['link'];
        
//        header('Content-type:application/json;charset=utf-8');
//        echo json_encode($video_data, JSON_UNESCAPED_UNICODE);
    }
    
    
