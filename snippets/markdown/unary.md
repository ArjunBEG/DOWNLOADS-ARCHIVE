---
title: unary
tags: function,beginner
---

Creates a function that accepts up to one argument, ignoring any additional arguments.

- Call the provided function, `fn`, with just the first argument supplied.

```js
const unary = fn => val => fn(val);
```

```js
['6', '8', '10'].map(unary(parseInt)); // [6, 8, 10]
```
