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

    $lib_alt = new Vimeo($config['client_id'], $config['client_secret'], $config['access_token']);
    $lib_base = new Vimeo($config['client_id_alt'], $config['client_secret_alt'], $config['access_token_alt']);
    
    $lib = $lib_base;
    
    $AlbumID = $_GET["album"];
    $PageNR = $_GET["page"];
    $perPage = $_GET["maxReturned"];
    $fields = $_GET["fields"];
    

if (!empty($config['access_token'])) {
    
    $lib->setToken($config['access_token']);
    $user = $lib->request('/me/albums/'.$AlbumID.'/videos?page='.$PageNR.'&per_page='.$perPage.'&fields='.$fields);
    
    
    
    
} else {
    $user = $lib->request('/users/dashron');
}

    header('Content-type:application/json;charset=utf-8');
    echo json_encode($user, JSON_UNESCAPED_UNICODE);
