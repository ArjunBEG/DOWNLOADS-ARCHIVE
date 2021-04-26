**This is a copy of an early attempt to imagine an implementation of 'style properties' in Svelte, as described in [this RFC](https://github.com/sveltejs/rfcs/pull/13). It is preserved here to satisfy curiosity, or in case we hate the new one.**

---

Style properties — handily distinguishable from regular properties by the leading `--` used by CSS custom properties — are passed down to components through a separate channel. The example at the top of this RFC might be converted to the following JavaScript:

```js
const slider = new Slider({
  props: {
    value: ctx.value,
    min: 0,
    max: 100
  },
  styles: {
    '--rail-color': 'black',
    '--track-color': 'red',
  }
});
```

These properties — `--rail-color` and `--track-color` etc — are essentially part of the interface of `<Slider>`, just like the `value`, `max` and `min` properties are.

Inside the Slider component, these styles would need to be applied to the top-level element — the equivalent of doing this:

```html
<span class="potato-slider" style="--rail-color: black; --track-color: red">
```

In practice that might look something like this:

```js
// internal helper
function apply_styles(node, styles) {
  for (const k in styles) {
    node.style.setProperty(k, styles[k]);
  }
}

function create_main_fragment(ctx) {
  // ...

  return {
    c() {
      span = element("span");
      apply_styles(span, ctx.$$styles);
    },
    // ...
    p(changed, ctx) {
      if (changed.$$styles) apply_styles(span, ctx.$$styles);
    },
    // ...
  };
}
```

(It would get slightly more complex for cases where there was an existing `style` attribute, particularly if it included a `--rail-color` property or was an opaque `style={styles}` type attribute. But the principle is the same.)

In the SSR case:

```js
return `<span class="${"potato-slider"}" style="${apply_ssr_styles($$styles)}">...</div>`;
```


### Inheritance

In the same way that custom properties applied to an element affect all descendant elements, custom properties applied to a component would affect all DOM within that component. It could be argued that this breaks encapsulation, but a) it matches the expectations people have from using custom properties to date, b) would in general be more convenient, and c) is more or less out of our hands since that's just how custom properties work.


### Multiple top-level elements

A component might have multiple top-level elements. In such cases, it would be necessary to apply the custom properties to all of them.

We could consider omitting them for elements that appear not to use the custom properties, and don't contain any components or any child elements that use them, but this might break expectations: it would be valid to select an element using global (or `:global`) CSS and expect the custom property to be present.


### Zero top-level elements

A trickier case is when there are no top-level elements, only components without any surrounding DOM. In these situations we would need to forward styles:

```html
<TopLevelComponent --foo={bar}>
```

```js
const toplevelcomponent = new TopLevelComponent({
  props: {...},
  styles: Object.assign({}, ctx.$$styles, {
    '--foo': ctx.bar
  })
});
```