You have an array. Its sort order doesn't matter. You want to remove an item from this array.

The obvious thing to do would be to use `splice`:

```js
function remove(array, item) {
  const index = array.indexOf(item);
  array.splice(index, 1);
}
```

But there's a [much faster way](https://mobile.twitter.com/Rich_Harris/status/1125850391155965952):

```js
function remove(array, item) {
  const index = array.indexOf(item);
  array[index] = array[array.length - 1];
  array.pop();
}
```

In my tests this is signficantly faster with large arrays, and never slower.

The fastest approach of all, though, is to use a set rather than an array:

```js
set.delete(item);
```

You can test for yourself by running this code in your console. Note that the bulk of the time is spent in `indexOf`, and this test makes finding an index as slow as possible:

```js
function test(size = 10000) {
  const array = [];
  for (let i = 0; i < size; i += 1) {
    if (i % 2 === 0) {
      array.push(i);
    } else {
      array.unshift(i);
    }
  }

  const set = new Set(array);

  function with_splice() {
    const clone = array.slice();
    console.time('with splice');
    for (let i = 0; i < size; i += 1) {
    const index = clone.indexOf(i);
      clone.splice(index, 1);
    }
    console.timeEnd('with splice');
  }

  function with_pop() {
    const clone = array.slice();
    console.time('with pop');
    for (let i = 0; i < size; i += 1) {
      const index = clone.indexOf(i);
      clone[index] = clone[clone.length - 1];
      clone.pop();
    }
    console.timeEnd('with pop');
  }

  function with_set() {
    console.time('with set');
    for (let i = 0; i < size; i += 1) {
      set.delete(i);
    }
    console.timeEnd('with set');
  }

  with_splice();
  with_pop();
  with_set();
}

test();
```