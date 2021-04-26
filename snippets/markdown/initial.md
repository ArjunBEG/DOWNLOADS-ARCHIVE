---
title: initial
tags: array,beginner
---

Returns all the elements of an array except the last one.

- Use `Array.prototype.slice(0, -1)` to return all but the last element of the array.

```js
const initial = arr => arr.slice(0, -1);
```

```js
initial([1, 2, 3]); // [1, 2]
```
