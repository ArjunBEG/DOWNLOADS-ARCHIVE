I've been deceiving you all. I had you believe that Svelte was a UI framework — unlike React and Vue etc, because it shifts work out of the client and into the compiler, but a framework nonetheless.

But that's not exactly accurate. In my defense, I didn't realise it myself until very recently. But with Svelte 3 around the corner, it's time to come clean about what Svelte really is.

**Svelte is a language.**

Specifically, Svelte is an attempt to answer a question that many people have asked, and a few have answered: what would it look like if we had a language for describing reactive user interfaces?

A few projects that have answered this question:

* [Elm](https://elm-lang.org/)
* [Imba](http://imba.io/)
* [Idyll](https://idyll-lang.org/)
* [Marko](https://markojs.com/)
* ...probably many others

(Idyll is an outlier as it's geared towards a specific use case, rather than general purpose app development, but I think it qualifies as an example.)

These projects are all very cool, but there's a reason they haven't hit mass adoption: they want to control the entire world. You can't adopt Elm or Imba incrementally, and they need dedicated tooling far beyond just the compiler itself (e.g. syntax highlighting, unless you like your code monochrome). In some cases (Elm stands out), interop with the JS ecosystem is less than seamless.

Beyond that, they have a steep learning curve, which is hard to justify when there are so many options that are more accessible.

## Thinking inside the box

What if we had a language that was designed for building reactive user interfaces, but that also worked with your existing tools? What if you didn't need you to discard your years of experience using HTML, CSS and JavaScript, because it extended those languages?

* It would extend HTML by adding JavaScript expressions in markup, directives for controlling behaviour and reacting to input, syntax for using conditions, loops and asynchronous values
* It would extend CSS by adding a scoping mechanism that kept styles from clobbering each other
* **It would extend JavaScript by making reactivity a language primitive**

How do we make reactivity a language primitive without introducing invalid syntax, or breaking the relationship with existing tooling (like TypeScript)? By hacking existing syntax:

* We [instrument assignments](https://github.com/sveltejs/rfcs/blob/master/text/0001-reactive-assignments.md) to variables and properties
* We [add `$:` statements](https://gist.github.com/Rich-Harris/aa3dc83d3d8a4e572d9be11aedc8c238), using the [little-known label construct](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/label), that run whenever their inputs change value
* We tie it all together with an opinionated scheduler

This, to me, is the best of all possible worlds: we can lean on decades of accumulated wisdom by extending well-known languages, author components in a delightfully concise and expressive way, and yet still generate apps that are bleeding-edge in terms of performance and everything that goes with it.