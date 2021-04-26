Simple argv parser in 100 bytes
===============================

Parses Unix (`-pewpew`, `--pew-pew=value`, `--pewpew value`) and Dos style (`/x`, `/x value`) argv strings

Input

```javascript
"node server.js -h 0.0.0.0 -p 80 -s -a --vvvv --r-x /v 123 /x --debug-enabled=yes"
```

Output

```javascript
{
  "h": "0.0.0.0",
  "p": "80",
  "s": true,
  "a": true,
  "vvvv": true,
  "r-x": true,
  "v": 123,
  "x": true,
  "debug-enabled": "yes"
}
```

Demo: http://jsfiddle.net/p3mc9/3/

Thx @maettig for help

Notice!
----

This parser can have a **strange behavior** if you pass full path names e.g. `-location /home/user/path/to/file.txt` it thinks that `/home` is dos-style argument name... Fix it if your file accepts paths - `\B[\/-]` -> `\B-`