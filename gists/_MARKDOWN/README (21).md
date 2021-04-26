Function returns sides of element that are **fully** in viewport

```
   +-----+ <- element .b-logo__image
   |     |
+--+-----+---+ <- viewport
|  |     |   |
|  +-----+   |
|            |
+------------+
```

```javascript
var element = document.querySelector('.b-logo__image');
getBordersInViewport(element);
/*{
    "top":false,
    "right":false,
    "bottom":true,
    "left":false,
    "all":false
}*/
```