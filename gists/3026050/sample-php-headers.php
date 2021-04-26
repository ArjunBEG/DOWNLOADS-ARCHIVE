301 moved permanently (redirect): 
<?php 
header('HTTP/1.1 301 Moved Permanently');
header('Location: http://www.example.com');
die();
?> 

302 moved temporarily(redirect): 
<?php 
header('Location: http://www.example.com');
die();
?> 

404 Page Not Found: 
<?php 
header('HTTP/1.1 404 Not Found');
?> 

Service not avaliable: 
<?php 
header('HTTP/1.1 503 Service Temporarily Unavailable');
header('Status: 503 Service Temporarily Unavailable');
header('Retry-After: 60');
?> 

CSS: 
<?php
header('Content-Type: text/css');
?> 

Javascript header: 
<?php 
header('Content-Type: application/javascript');
?> 

Images:
For JPEG(jpg): 
<?php 
header('Content-Type: image/jpeg');
?> 
For PNG: 
<?php 
header('Content-Type: image/png');
?> 
For BMP: 
<?php 
header('Content-Type: image/bmp');
?> 

PDF (output pdf with php): 
<?php 
header('Content-Type: application/pdf');
echo file_get_contents('filename.pdf');
?> 

Cache (force browsers not to cache files): 
<?php 
header('Expires: Sat, 26 Jul 1997 05:00:00 GMT');
header('Cache-Control: no-store, no-cache, must-revalidate');
header('Cache-Control: pre-check=0, post-check=0, max-age=0');
header ('Pragma: no-cache'); 
?> 

Download dialog: 
<?php 
header('Content-Disposition: attachment; filename=' . urlencode($f));   
header('Content-Type: application/force-download');
header('Content-Type: application/octet-stream');
header('Content-Type: application/download');
header('Content-Description: File Transfer');            
header('Content-Length: ' . filesize($f));
echo file_get_contents($f);
?> 

Authentication (force the browser to pop up a Username/Password input window) - only available when PHP is running as an Apache module: 
<?php
if (!isset($_SERVER['PHP_AUTH_USER'])) {
    header('WWW-Authenticate: Basic realm="The Realm"');
    header('HTTP/1.0 401 Unauthorized');
    echo 'If cancel is pressed this text shows';
    die();
} else {
//always escape your data//
$user='user';
$pass='pass';
   if($_SERVER['PHP_AUTH_USER']==$user && $_SERVER['PHP_AUTH_PW']==$pass){
    echo 'Authorized';
}
}
?>