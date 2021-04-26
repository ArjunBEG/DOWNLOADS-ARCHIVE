https://github.com/w3c/webcomponents/issues/759

Suppose you have an app like this, and your bundler turns .css files into strings:

```js
// main.js
import './x-foo.js';
import './x-bar.js';

document.body.innerHTML = `<x-foo></x-foo><x-bar></x-bar>`;
```

```js
// x-foo.js
import styles from './x-foo.css';

customElements.define('x-foo', class XFoo extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({mode: 'open'});
    this.shadowRoot.innerHTML = `
      <style>${styles}</style>
      <p>foo</p>
    `;
  }
});
```

```js
// x-bar.js
import styles from './x-bar.css';

customElements.define('x-bar', class XBar extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({mode: 'open'});
    this.shadowRoot.innerHTML = `
      <style>${styles}</style>
      <p>bar</p>
    `;
  }
});
```

```css
/* x-foo.css */
:host {
  color: red;
}
```

```css
/* x-bar.css */
:host {
  color: bar;
}
```

Rollup would create a single JS file...

```js
const styles = `:host {
  color: red;
}`;

const styles$1 = `:host {
  color: blue;
}`;

customElements.define('x-foo', class XFoo extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({mode: 'open'});
    this.shadowRoot.innerHTML = `
      <style>${styles}</style>
      <p>foo</p>
    `;
  }
});

customElements.define('x-bar', class XBar extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({mode: 'open'});
    this.shadowRoot.innerHTML = `
      <style>${styles$1}</style>
      <p>foo</p>
    `;
  }
});

document.body.innerHTML = `<x-foo></x-foo><x-bar></x-bar>`;
```

CSS modules would allow us to avoid storing styles in JavaScript string blobs, which is a good thing. But the equivalent app...

```js
// x-foo.js
import styles from './x-foo.css';

customElements.define('x-foo', class XFoo extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({mode: 'open'});
    this.shadowRoot.adoptedStyleSheets = [styles];
    this.shadowRoot.innerHTML = '<p>foo</p>';
  }
});
```

```js
// x-bar.js
import styles from './x-bar.css';

customElements.define('x-bar', class XBar extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({mode: 'open'});
    this.shadowRoot.adoptedStyleSheets = [styles];
    this.shadowRoot.innerHTML = '<p>bar</p>';
  }
});
```

...can't get optimised into a single JS file and a single CSS file, as far as I can tell. Instead, the JS bundle would need to import the two .css files separately.

Experience has established that shipping *n* small JavaScript modules yields suboptimal performance relative to coarse-grained code-split chunks. There's no reason to suspect *n* small CSS files should be any different. I wonder, therefore, if we should consider whether there's an alternative to one-stylesheet-per-file.