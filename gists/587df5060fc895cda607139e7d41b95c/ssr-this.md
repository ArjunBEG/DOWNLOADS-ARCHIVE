[Responding to this Twitter convo](https://twitter.com/lastmjs/status/891329019454431235) —

Let's say I'm building a blog post template page using from kind of front-end framework — for the sake of argument, we'll use [Svelte](https://svelte.technology). On this page, we'll have a share button that lets people share the blog post via Twitter.

Twitter makes this straightforward using their [tweet web intent](https://dev.twitter.com/web/tweet-button/web-intent) — just create an `<a>` tag with the appropriate `href`, and Twitter will take it from there. This is great — no need to faff around with an API.

But constructing the URL gets a bit unwieldy, so we'd like to turn it into a component:

```html
<TwitterShare
	text="Server-side rendering of web components is hard"
	url="https://gist.github.com/Rich-Harris/587df5060fc895cda607139e7d41b95c"
	via='sveltejs'
/>
```

When we render this on the server, this is the markup that gets generated:

```
<a svelte-3655588705="" target="_blank" href="https://twitter.com/intent/tweet?text=Server-side%20rendering%20of%20web%20components%20is%20hard&amp;url=https%3A%2F%2Fgist.github.com%2FRich-Harris%2F587df5060fc895cda607139e7d41b95c&amp;via=sveltejs">Share on Twitter</a>
```

Needless to say, this works everywhere, with or without JavaScript. If we *do* have JavaScript, then we can enhance the experience by creating a nicely-sized and -positioned popup window rather than opening a new tab. That's a good example of progressive enhancement.

[You can see a demo of it here](https://svelte.technology/repl?version=1.26.2&gist=229bf6bb71bf4df1cc56772ce6511be3). Notice that we have encapsulated styles, and we can do sophisticated things like client-side hydration using a universal codebase.

**As far as I'm aware, you simply cannot do this with web components.** At a bare minimum, you need some JavaScript to hydrate the `<twitter-share>` custom element.