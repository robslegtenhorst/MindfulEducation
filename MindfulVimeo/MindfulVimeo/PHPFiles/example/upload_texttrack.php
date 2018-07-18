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
     *
     *      USAGE ::
     *      CLI > php thisFile.php videofile videoName subtitleAmount subFile locale subtitleAmount subFile locale subtitleAmount subFile locale etc
     
     php /Applications/XAMPP/xamppfiles/htdocs/vimeo/example/upload_vidText.php /users/42291155/albums/4751088 /Users/robslegtenhorst/RENDER/WalsallLogo_v002.mp4 test_name 2 /Users/robslegtenhorst/RENDER/temp_logo/subs/CAR_AAT-L2_U01/car_aat-l2_u01_l01_p01_v007_MASTERED/car_aat-l2_u01_l01_p01_v007_MASTERED.en-GB_Welsh.vtt cy /Users/robslegtenhorst/RENDER/temp_logo/subs/CAR_AAT-L2_U01/car_aat-l2_u01_l01_p01_v007_MASTERED/English\ \(United\ Kingdom\).vtt en-GB
     
     
     TODO
     loop for multiple files, somehow link files
     groups
     
     *
     */
    
    $config = require(__DIR__ . '/init.php');
    
    if (empty($config['access_token'])) {
        throw new Exception('You can not upload a file without an access token. You can find this token on your app page, or generate one using auth.php');
    }
    
    $lib_alt = new Vimeo($config['client_id'], $config['client_secret'], $config['access_token']);
    $lib_base = new Vimeo($config['client_id_alt'], $config['client_secret_alt'], $config['access_token_alt']);
    
    $lib = $lib_base;
    
    // check xrate and uplaod quota
    $rate_args = array('fields' => ['upload_quota']);
    $rate_data = $lib->request('/me/',$rate_args);
    
    print "X-Rate Status :: ".$rate_data['status']."\n";
    if($rate_data['status'] == 200 || $rate_data['status'] == 429) {
        if($rate_data['status'] == 429) {
            print "X-RateLimit reached, trying alternative\n";
            $lib = $lib_alt;
            $rate_data = $lib->request('/me/',$rate_args);
        }
        //        print "X-RateLimit-Limit :: ".$rate_data['headers']['X-RateLimit-Limit']."\n";
        print "X-RateLimit-Remaining :: ".$rate_data['headers']['X-RateLimit-Remaining']."\n";
        //        print "X-RateLimit-Reset :: ".$rate_data['headers']['X-RateLimit-Reset']."\n";
        
        if ($rate_data['body']['upload_quota']['quota']['hd'] == 0) {
            print "upload quota exceeded";
        } else {
            
            if ($rate_data['headers']['X-RateLimit-Remaining'] < 10) {
                $lib = $lib_alt;
                print "base rate exceeded, testing alt id";
                $rate_alt_args = array('fields' => ['upload_quota']);
                $rate_alt_data = $lib->request('/me/',$rate_alt_args);
                print "Alt X-RateLimit-Remaining :: ".$rate_alt_data['headers']['X-RateLimit-Remaining']."\n";
                
                if($rate_alt_data['headers']['X-RateLimit-Remaining'] < 20)
                {
                    print "alt Rate exceeded, wait till ".$rate_data['headers']['X-RateLimit-Reset'];
                    exit;
                }
            }
            
            
            //  Get the args from the command line to see what files to upload.
            $files = $argv;
            array_shift($files);
            
            $videoTT_uri = $files[0];
            
            $album_uri = $files[1];
            $video_uri = $files[2];
            
            $texttrack_amount = $files[3];
            
            if ($texttrack_amount != 0)
            {
                for ($i = 0; $i <= $texttrack_amount-1; $i++) {
                    $currentIndex = 2 + (2 * ( $i + 1 ));
                    
                    $currentPathVal = $files[$currentIndex];
                    $currentLocaleVal = $files[$currentIndex+1];
                    
                    $texttrack_array[$i] = [$currentPathVal,$currentLocaleVal];
                    //        print "index :: ".$currentIndex ." -- path :: ". $texttrack_array[$i][0] ." -- locale :: ". $texttrack_array[$i][1]."\n";
                }
            }
            
            print "setting subtitles .\n";
                
                // Find the text track URI. This is also the URI that you can query to view all text tracks associated with this resource.
                
                $subs_args = array('fields' => [$videoTT_uri]);
                
                if ($texttrack_amount != 0)
                {
                    foreach ($texttrack_array as $texttrack_details) {
                        
                        print "texttrack uri :: ".$videoTT_uri."\n";
                        print "texttrack locale :: ".$texttrack_details[1]."\n";
                        
                        // You are always required to set a text track type and language as the 3rd and 4th parameters respectively.
                        if(isset($response)) var_dump($response);
                        $response = $lib->uploadTexttrack($videoTT_uri, $texttrack_details[0], "subtitles", $texttrack_details[1]);
                        
                    }
                }
                
                $albumReq_uri = $album_uri.$video_uri;
                $albumReq_args = array('fields' => ['name']);
                print "uri :: ".$albumReq_uri;
                
                $albumReq = $lib->request($albumReq_uri, $albumReq_args, 'PUT');
                
                if ($albumReq['status'] == 403) {
                    foreach ($albumReq as $item) {
                        echo $item;
                    }
                    throw new Exception('move to album failed :: Forbidden ::' .$albumReq);
                } else if ($albumReq['status'] == 404) {
                    foreach ($albumReq as $item) {
                        echo $item;
                    }
                    throw new Exception('move to album failed :: NOT FOUND ::' .$albumReq);
                } else if ($albumReq['status'] == 200) {
                    print "album status code :: ".$albumReq['status']."\n";
                    
                } else if ($albumReq['status'] == 204) {
                    print "album status code :: ".$albumReq['status']."\n";
                    
                }
                
            }
    }
