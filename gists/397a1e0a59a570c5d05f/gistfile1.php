<?php
	$url = 'http://merchant.admin.cdon.com/api/importfile';

	$key = 'nanana BATMAN';
	$file_name_with_full_path = realpath('./Clothing.xlsx');
	$post = array('name' => 'file', 'filename' => 'Clothing.xlsx', 'file_contents'=>'@'.$file_name_with_full_path);
 
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,$target_url);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
		'Content-Type: application/xml',
		'Authorization: api '+$key
		));
	curl_setopt($ch, CURLOPT_POST,1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	$result = curl_exec ($ch);
	curl_close ($ch);
	echo $result;
?>