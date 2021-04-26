The fundamental problem with top-level await is that it prevents two unrelated modules doing asynchronous work in parallel, because module evaluation order is strictly deterministic.

What if we provided an escape valve that relaxed that constraint?

```js
// main.js
import foo from async './foo.js';
import bar from async './bar.js';
import baz from './baz.js';

console.log(foo, bar, baz);
```

```js
// foo.js
export default await fetch('/foo.json').then(r => r.json());
console.log('got foo');
```

```js
// bar.js
export default await fetch('/bar.json').then(r => r.json());
console.log('got bar');
```

```js
export default 'BAZ';
console.log('got baz');
```

By using `from async`, we're allowing `foo.js` and `bar.js` to use top-level `await`. (If a consumer were to just use `from`, it would be an error.)

The output of this (assuming foo.json contains `"FOO"` and bar.json contains `"BAR"`) could be either of these:

```
BAZ
FOO
BAR
FOO BAR BAZ
```

```
BAZ
BAR
FOO
FOO BAR BAZ
```

This is roughly analogous to wrapping `foo.js` and `bar.js` in async functions, except that `main.js` awaits both of them:

```js
async function foo() {
  const result = await fetch('/foo.json').then(r => r.json());
  console.log('got foo');
  return result;
}

async function bar() {
  const result = await fetch('/bar.json').then(r => r.json());
  console.log('got bar');
  return result;
}

function baz() {
  const result = 'BAZ';
  console.log('got baz');
  return result;
}

function main() {
  Promise.all([foo(), bar(), baz()]).then(([foo, bar, baz]) => {
    console.log(foo, bar, baz);
  });
}
```

I've argued [elsewhere](https://gist.github.com/Rich-Harris/9a270920e203e6df9477ca02318fb640) that determinism is important, but maybe if we can opt-in to non-determinism with our eyes open, it's okay?
