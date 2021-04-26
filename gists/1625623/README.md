Tiny ajax: xhr get, post, whatever - for modern browsers in 130 bytes
=========

```javascript
function tiny_ajax(method, url, callback, post_data) {/* ... */}

// asynch call
tiny_ajax('get', '.', function (xhr) {
    console.log(xhr.responseText);
});

tiny_ajax('post', '.', function (xhr) {
    console.log(xhr.responseText);
}, 'data');

// synch call
var xhr = tiny_ajax('get', '.');

var xhr = tiny_ajax('post', '.', 0, 'data');
```

Demo: http://jsfiddle.net/y3msq/

There is also crossbrowse one, but 155 bytes long

```javascript
function(m,u,c,d){with(new(this.XMLHttpRequest||ActiveXObject)("Microsoft.XMLHTTP"))onreadystatechange=function(){readyState^4||c(this)},open(m,u),send(d)}
```