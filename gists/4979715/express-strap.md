```
app="YOUR_APP_NAME"
mkdir $app
cd $app
git init
touch README.MD
echo "$app \n=\nWill add more info soon." >> README.MD 
sudo npm install -g express less uglify-js 
express --css less -e
mkdir vendor
git submodule add git://github.com/twitter/bootstrap.git vendor/bootstrap
git submodule init 
git submodule update
cd vendor/bootstrap
sudo npm i recess connect uglify-js jshint -g
make bootstrap
mkdir ../../public/bootstrap
cd ../../public
ln -s ../vendor/bootstrap/bootstrap ./
mv images img && mv javascripts js && mv stylesheets css
```

Now, go into your `views` directory and update the path in your `index.ejs` file for the css directory.  Add your boostrap references to your view as well.

```
<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    <link rel='stylesheet' href='/bootstrap/css/bootstrap.css' />
    <link rel='stylesheet' href='/bootstrap/css/bootstrap-responsive.css' />
    <link rel='stylesheet' href='/css/style.css' />
  </head>
  <body>
    <h1><%= title %></h1>
    <p>Welcome to <%= title %></p>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
    <script src="/bootstrap/js/bootstrap.js"></script>
  </body>
</html>
```
