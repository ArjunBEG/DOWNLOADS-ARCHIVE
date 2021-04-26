HOW IT WORKS

The function takes two arguments:

The $cache_file argument stores the server location of the cache file you wish to use. By default it will look for api-cache.json in the same directory as the script using this function.

The $expires argument will store the time between each API request. By default a new API request will be made every 2 hours.
You’ll need to create the cache file with CHMOD 777 permissions before this function will work. The function will check to see if the cache file exists using file_exists(), throwing an error message if it does not. If the cache file exists, the script will check to see if it’s empty using file_get_contents(). If it is empty an initial API request is made and the results are stored as JSON in the cache file using file_put_contents(). If the cache file exists and is not empty the script will check the last time the file was modified using filectime(). If it was modified longer than the $expires time an API request is made and the file is updated.