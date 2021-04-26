A modest proposal for a first-class [destiny operator](http://paulstovell.com/blog/reactive-programming) equivalent in Svelte components that's also valid JS.

Svelte 2 has a concept of [computed properties](https://svelte.technology/guide#computed-properties), which are updated whenever their inputs change. They're powerful, if a little boilerplatey, but there's currently no place for them in [Svelte 3](https://github.com/sveltejs/rfcs/blob/reactive-assignments/text/0001-reactive-assignments.md).

This means that we have to use functions. Instead of this...

```html
<!-- Svelte 2 -->
<h1>HELLO {NAME}!</h1>

<script>
  export default {
    data: () => ({ name: 'world' }),
    computed: {
      NAME: ({ name }) => name.toUpperCase()
    }
  };
</script>
```

...we have to do this:

```html
<script>
  export let name = 'world';
  const NAME = () => name.toUpperCase();
</script>

<h1>HELLO {NAME()}!</h1>
```

But that has some serious downsides, especially when those functions depend on other function values. In the `current.html` example below, `x_scale` and `y_scale` are invoked twice *per point*. Each call to `x_scale` invokes `min_x()` and `max_x()`, and similarly for `y_scale`. That won't do.

Of course, the compiler could, in *some* cases, do some kind of automatic memoisation, if it was [sufficiently smart](http://wiki.c2.com/?SufficientlySmartCompiler). But such an approach would be riddled with caveats, and as a user I'm not sure I'd trust the compiler to do the right thing if I was staring at code that looks as though it's going to result in thousands of unnecessary function calls.


## A syntax-abusing alternative

We can't implement the destiny operator, because it's not valid JS — parser, linters, typecheckers etc wouldn't be able to work with it. But there's a piece of syntax in JavaScript that we can use in its place: the [labeled statement](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/label).

This is valid JS:

```js
let name = 'world';
let NAME;

compute:NAME = name.toUpperCase();
```

See `proposed.html` below for a more complete example. The dependency graph is topologically sorted at compile time, and values that could have changed are recomputed once per update cycle.


## Combining multiple computed values

Another benefit of this approach is that we could combine multiple computed values into a single block. As an alternative to this...

```js
compute:min_x = Math.min(...points.map(p => p.x));
compute:max_x = Math.max(...points.map(p => p.x));
compute:min_y = Math.min(...points.map(p => p.y));
compute:max_y = Math.max(...points.map(p => p.y));
```

...we could do this, iterating over `points` once instead of mapping it four times:

```js
compute: {
  min_x = Infinity; max_x = -Infinity; min_y = Infinity; max_y = -Infinity; // reset
  
  points.forEach(point => {
    if (point.x < min_x) min_x = point.x;
    if (point.x > max_x) max_x = point.x;
    if (point.y < min_y) min_y = point.y;
    if (point.y > max_y) max_y = point.y;
  });
}
```


## Further thoughts

This could maybe work with [sources](https://github.com/sveltejs/rfcs/blob/svelte-observables/text/0002-observables.md) as well — would this make sense?

```js
import { todos } from './sources.js;'

let currentFilter = 'all';
let filteredTodos;

bind:filteredTodos = $todos.filter(currentFilter);
```