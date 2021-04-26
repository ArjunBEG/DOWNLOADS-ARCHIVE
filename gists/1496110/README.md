File system tree builder
========================

1. all paths must be absolute
2. last item in path is file

```javascript
var input = ['/a/b/.git/config', '/a/x/d/x.js', '/a/x/d/x/ololo.xml'];

var output = {
  "#": {
    "a": {
      "x": {
        "d": {
          "x": {
            "ololo.xml": "ololo.xml"
          },
          "x.js": "x.js"
        }
      },
      "b": {
        ".git": {
          "config": "config"
        }
      }
    }
  }
}
```

demo: http://jsfiddle.net/bnhyF/