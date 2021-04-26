Recently, I was reminiscing about the `<plaintext>` tag.

> https://developer.mozilla.org/en-US/docs/Web/HTML/Element/plaintext

It made me think of trying this silly JS snippet experiment.

Pasting it into the dev tools console will show a "view source" of the page.

```
document.documentElement.innerHTML =
`<plaintext>${
document.documentElement.innerHTML
}`
.replace(/\n\s+/g, '\n');
```