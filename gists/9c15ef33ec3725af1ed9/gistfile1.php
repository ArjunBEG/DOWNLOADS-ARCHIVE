<?php

    // headers for proxy servers
    $headers = [
        "Accept" => "*/*",
        "Connection" => "Keep-Alive",
        "User-Agent" => sprintf("curl/%s", curl_version()["version"])
    ];

    // open connection to Yahoo
    $context = stream_context_create([
        "http" => [
            "header" => implode(array_map(function($value, $key) { return sprintf("%s: %s\r\n", $key, $value); }, $headers, array_keys($headers))),
            "method" => "GET"
        ]
    ]);
    $handle = fopen("http://www.xhaus.com/headers", "r", false, $context);
    if ($handle === false)
    {
        // trigger (big, orange) error
        trigger_error("Could not connect to Yahoo!", E_USER_ERROR);
        exit;
    }
    $contents = fread($handle, 1048576);
    print_r($contents);
    
?>