---
title: getScrollPosition
tags: browser,intermediate
---

Returns the scroll position of the current page.

- Use `Window.pageXOffset` and `Window.pageYOffset` if they are defined, otherwise `Element.scrollLeft` and `Element.scrollTop`.
- Omit the single argument, `el`, to use a default value of `window`.

```js
const getScrollPosition = (el = window) => ({
  x: el.pageXOffset !== undefined ? el.pageXOffset : el.scrollLeft,
  y: el.pageYOffset !== undefined ? el.pageYOffset : el.scrollTop
});
```

```js
getScrollPosition(); // {x: 0, y: 200}
```
