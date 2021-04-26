# A concept diff from Svelte 2 to 3

```diff
-A component must have a default export, but the default export is not the component
-The default export and its properties must be structured a certain way, you can't just use JavaScript
-Components, actions, animations, transitions, custom events etc must be registered, not just imported
-Components can be registered with a shorthand, because the normal way is cumbersome
-methods are attached to the prototype, and `this` is the component, even though it looks (including to linters and typecheckers) as though the `methods` object itself is the context
-Events must be method calls, not arbitrary expressions
-`event` has a special meaning in method calls, as does `this`, as does `refs`, as do `console` and other special names
-`on:click` and `on:myevent` mean different categories of thing
-variables must be accessed with this.get, which also includes computed properties and store properties
-this.store
-names in templates can refer to props that were passed in, props returned from the `data` function, helpers, computed properties, or a subset of whitelisted globals
-Directives are syntactically distinct from attributes
-Refs are unlike other directives (they can't have a value)
-DOM events and component events are different kinds of things, even though you listen to them the same way
-`setup`
-`preload` as a special static method
-`onstate`, `oncreate`, `onupdate`, `ondestroy`, plus event equivalents (except for `oncreate`)
-`get`, `set`, `fire`, `on`, `destroy`

+Assigning to a value triggers a state change
+Some values can be made accessible to the outside world with `export`
+`onMount`, `onDestroy`, `beforeRender`, `afterRender`
+`createEventDispatcher` and `dispatch`
+`$on`, `$destroy` (and `$set` but you won't actually need it)
+`<script context="module">`
```