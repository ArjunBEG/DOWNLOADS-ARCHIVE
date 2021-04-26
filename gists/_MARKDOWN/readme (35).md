# collection loader

This an example collection loader for the upcoming, major refactor of templates.

## Setup

Create a collection with `app.create()` or with `new Collection()`. 

```js
const Collection = require('templates/lib/collection');
const collection = new Collection();
collection.use(loader());
```
