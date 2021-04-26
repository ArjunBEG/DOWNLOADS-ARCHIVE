<?php
function generateSlug($phrase, $maxLength) {
    $result = strtolower($phrase);
    $result = preg_replace("/[^a-z0-9\s-]/", "", $result);
    $result = trim(preg_replace("/[\s-]+/", " ", $result));
    $result = trim(substr($result, 0, $maxLength));
    $result = preg_replace("/\s/", "-", $result);
    return $result;
}

$title = "A bunch of ()/*++\'#@$&*^!%     invalid URL characters  ";

echo(generateSlug($title));

//Output:
//a-bunch-of-invalid-url-characters