<?php

$dirname = "./"; // Change this to your directory; this is the current directory

$dir = opendir($dirname);

while(false != ($file = readdir($dir))){
  if(($file != ".") and ($file != "..")){
		echo($file);
		echo("\n");
	}
}

?>

