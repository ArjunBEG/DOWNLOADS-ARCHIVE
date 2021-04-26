---
title: isWeekend
tags: date,beginner
---

Checks if the given date is a weekend.

- Use `Date.prototype.getDay()` to check weekend by using a modulo operator (`%`).
- Omit the argument, `d`, to use the current date as default.

```js
const isWeekend = (d = new Date()) => d.getDay() % 6 === 0;
```

```js
isWeekend(); // 2018-10-19 (if current date is 2018-10-18)
```
