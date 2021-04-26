Give it a go:

    git clone https://gist.github.com/6200029.git make-asset-compilation
    cd make-asset-compilation
    npm install
    node_modules/.bin/bower install
    mkdir -p javascripts sass public
    echo 'console.log("Hello world");' > javascripts/myapp.js
    echo 'html { background: papayawhip; }' > sass/myapp.scss
    make

And then look in `public` to see your compiled files.

To watch it auto-recompile on file change, run `make watch` and then edit `javascripts/myapp.js` or `sass/myapp.scss`