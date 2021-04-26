Responding to https://mobile.twitter.com/Sawtaytoes/status/1120478565454307328:

Here's an example component representing a work-in-progress screen for a concert ticket sales website, built for a recent demo:

```html
<script>
  let type;
  let count = 1;
  let seconds = 300;

  setInterval(() => seconds--, 1000);

  $: m = Math.floor(seconds / 60);
  $: s = seconds % 60;
</script>

<div class="app border-radius drop-shadow lt-center">
  <h1>Ticketmaestro</h1>

  <h2>Select seat type</h2>
  <select bind:value={type}>
    <option>cheap</option>
    <option>standard</option>
    <option>exorbitant</option>
  </select>

  <h2>Select quantity</h2>
  <input id="input" type="number" bind:value={count}>

  <div id="order">
    <p>Buy <strong>{count} {type}</strong>
      {count == 1 ? 'ticket' : 'tickets'}
    </p>

    <p>You have {m}:{s < 10 ? '0' + s : s}
      to complete your order</p>
  </div>
</div>
```

You can see a live version [here](https://svelte.dev/repl?version=3.0.0&gist=6d85de61dea75a8c38157456dfaf05bf).

The Knockout equivalent would have two files — HTML and JS:

```html
<h1>Ticketmaestro</h1>

<h2>Select seat type</h2>
<select id="select" data-bind="value: type">
  <option>cheap</option>
  <option>standard</option>
  <option>exorbitant</option>
</select>

<h2>Select quantity</h2>
<input id="input" type="number" data-bind="value: count">

<div id="order">
  Buying
  <span data-bind="text: count"></span>
  <span data-bind="text: type"></span>
  <span data-bind="text: count() === 1 ? 'ticket' : 'tickets'"></span>

  You have
  <span data-bind="text: remaining"></span>
  to complete your order
</div>
```

```js
function OrderViewModel() {
  this.type = ko.observable('cheap');
  this.count = ko.observable(1);
  this.seconds = ko.observable(300);

  this.remaining = ko.computed(() => {
    const m = Math.floor(this.seconds() / 60);
    const s = this.seconds() % 60;

    return \`\${m}:\${s < 10 ? '0' + s : s}\`;
  }, this);

  setInterval(() => {
    this.seconds(this.seconds() - 1);
  }, 1000);
}

ko.applyBindings(new OrderViewModel());
```

(Neither represents production-quality code, this is purely for illustration.)

Differences:

* The Svelte version is 660 characters in 1 file, the Knockout one is 969 characters in two files. You have to write a lot more code, and you have components declared in separate tightly-coupled files
* With Knockout, you need the 68kb library. Svelte is self-contained
* You have to deal with `ko.observable(...)` in Knockout, which makes marshaling data (e.g. from an API server) a pain
* The Svelte syntax is far more flexible and idiomatic
* Svelte has a mechanism for component-scoped stying. Knockout doesn't know anything about CSS
* Knockout can't do SSR, as far as I'm aware (at least, not sensibly)
* Svelte has many features that are far out of scope for Knockout (e.g. declarative transitions)

None of which is intended as criticism — I was a big fan of Knockout back in the day. It was an important and forward-looking project. But they are *extremely* different.