I'm procrastinating instead of working on a conference talk, so I decided to implement [this component](https://mobile.twitter.com/trek/status/1112064069031395329) in Svelte to see which framework is most expressive:

<img width="512" alt="Screen Shot 2019-03-30 at 16 42 16" src="https://user-images.githubusercontent.com/1162160/55281443-d764da00-530a-11e9-91bf-6ec0076009b6.png">

## Ember Octane

Here's the [original](https://gist.github.com/trek/42f95212d52c8d24794f2f90001a9185), with the addition of an import for `dataUriAsSrc` (and updated per @chriskrycho's comment):

```handlebars
<img
  class='rounded-full object-cover'
  src={{this.src}}
  alt="Profile image for {{@name}}"
  height={{this.size}}
  width={{this.size}}
  onerror={{this.useLetterform}}
>
```

```js
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import dataUriAsSrc from './dataUriAsSrc.js';

export default class AvatarComponent extends Component {
  size = 48;
  @tracked letterform;

  get src() {
    return this.letterform
      ? this.letterform
      : `https://example.com/avatars/${this.args.companyId}`;
  }

  @action useLetterform() {
    this.letterform = dataUriAsSrc(this.args.name, this.size);
  }
}
```

## Svelte

Here's a Svelte version ([demo](https://v3.svelte.technology/repl?version=3.0.0-beta.22&gist=42a6bb06d2df38d12a5c95c9e6a81eda)):

```html
<script>
  import dataUriAsSrc from './dataUriAsSrc.js';

  export let size = 48;
  export let name;
  export let companyId;

  let letterform = false;

  $: src = letterform
    ? dataUriAsSrc(name, size)
    : `https://example.com/avatars/${companyId}`;
</script>

<img
  class="rounded-full object-cover"
  alt="Profile image for {name}"
  src={src}
  width={size}
  height={size}
  on:error={() => letterform = true}
>
```

## React

And here's one using React hooks ([demo](https://codesandbox.io/s/n7z1qpzvp0)):

```js
import React, { useState, useMemo } from "react";
import dataUriAsSrc from "./dataUriAsSrc.js";

export default function Avatar({ size = 48, name, companyId }) {
  const [letterform, setLetterform] = useState(false);

  const src = useMemo(
    () => letterform
      ? dataUriAsSrc(name, size)
      : `https://example.com/avatars/${companyId}`,
    [letterform, name, companyId, size]
  );

  return (
    <img
      className="rounded-full object-cover"
      alt={`Profile image for ${name}`}
      src={src}
      width={size}
      height={size}
      onError={() => setLetterform(true)}
    />
  );
}
```

---

They're all pretty sleek — much more so than frameworks of yore. I find it useful to compare both lines of source code *and* bytes of source code (to count bytes, copy to clipboard then run `pbpaste | wc -c` in your terminal):

| framework | lines of code | bytes of code |
| --------- | ------------- | ------------- |
| Svelte    | **22**        | **422**       |
| React     | 24            | 607 (+44%)    |
| Ember     | 27            | 673 (+59%)    |

In summary: use [Svelte](https://v3.svelte.technology) 😜