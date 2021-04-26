---
title: isBoolean
tags: type,beginner
---

Checks if the given argument is a native boolean element.

- Use `typeof` to check if a value is classified as a boolean primitive.

```js
const isBoolean = val => typeof val === 'boolean';
```

```js
isBoolean(null); // false
isBoolean(false); // true
```
