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

$lib = new Vimeo($config['client_id_alt'], $config['client_secret_alt'], $config['access_token_alt']);
    
$argsSent = $argv;
    
    array_shift($argsSent);
    
    $videoPictURI = $argsSent[0];

//set poster frame

print "videoPosterURI :: ".$videoPictURI."\n";
$setPoster_args = array('time' => 17, 'active' => true, 'fields' => ['name']);
$setPoster = $lib->request($videoPictURI, $setPoster_args, 'post');
if ($setPoster['status'] != 201) {
    foreach ($setPoster as $item) {
        print "found an item :: ".$item."\n";
    }
    throw new Exception('set poster failed ' .$setPoster['status']);
}
    
