So far, most of us have been writing Svelte components into `.html` files, with a few exceptions (Parcel users, for example, have additional constraints to work with). We're currently discussing whether this should change.

Once you've read the pros and cons, [please vote](https://www.strawpoll.me/17385204)!

## .html

Pros:

* It signals that you can use your existing HTML (and CSS) knowledge
* Valid HTML is valid Svelte
* Syntax highlighting *mostly* works everywhere OOTB (expressions in `{tags}` are treated as text, though)

Cons:

* Svelte components aren't really HTML
* Tools like Parcel can't deal with it
* We don't get full syntax highlighting
* Some tools, like WebStorm, struggle with directives etc


## .htmlx

Pros:

* It signals that it's HTML-with-extras
* Symmetry with `.js` and `.jsx`
* It's an invitation to other frameworks to collaborate, rather than continuously reinventing template languages

Cons:

* No syntax highlighting out of the box — imposes tooling requirements on users, could be offputting for new recruits
* It's a land grab
* May be hard to get Linguist to adopt Svelte syntax highlighting for it


## .svelte

Pros:

* Does what it says on the tin. Zero ambiguity
* Linguist support — we should be able to claim `svelte` for fenced code blocks
* It's unlikely to cause conflict with other frameworks etc

Cons:

* No syntax highlighting. Like `.htmlx`, the first-time experience is poor