I have a real mental blockage around this stuff. Partly because the docs could probably be a little better, partly because it's changed over the years, probably partly because I'm dumb. Whatever. I'm going to try and document how to do stuff I occasionally need to do, so I can refer to it next time.

## Return value of `pipe`

```js
x.pipe(y) === y; // true
```

```js
x.on(someEvent, callback) === x; // true
```

## Creating a transform stream

```js
const myTransform = new Transform({
  transform(chunk, encoding, callback) {
    callback(doSomethingWith(chunk));
  }
});

fs.createReadStream('somefile.txt').pipe(myTransform);
```

## Flowing vs paused mode

Readable streams default to 'paused mode'. The data doesn't start flowing unless you

* add a 'data' event handler
* call `stream.resume()`
* call `stream.pipe(writable)`

More information [here](https://nodejs.org/api/stream.html#stream_two_reading_modes). God, what a mess.

TODO what are the available events, does closing `z` in `x.pipe(y).pipe(z)` close `x`, etc