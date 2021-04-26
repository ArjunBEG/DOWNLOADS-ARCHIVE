<?php
function cache_image($image_url){
    //replace with your cache directory
    $image_path = 'path/to/cache/dir/';
    //get the name of the file
    $exploded_image_url = explode("/",$image_url);
    $image_filename = end($exploded_image_url);
    $exploded_image_filename = explode(".",$image_filename);
    $extension = end($exploded_image_filename);
    //make sure its an image
    if($extension == "gif" || $extension == "jpg" || $extension == "jpeg" || $extension == "png") {
        //get the remote image
        $image_to_fetch = file_get_contents($image_url);
        //save it
        $local_image_file = fopen($image_path.$image_filename, 'w+');
        chmod($image_path.$image_filename,0755);
        fwrite($local_image_file, $image_to_fetch);
        fclose($local_image_file);
    }
}
//usage
//cache_image(“http://www.flickr.com/someimage.jpg”);