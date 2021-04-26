This is based off [work by @mrkishi](https://gist.github.com/mrkishi/6f2e5946dd430eed08a9a951c63b8295#file-multiple-js), and is an attempt to do the following:

* Multiple spread props on elements/components
* Later props override earlier ones
* Updates are conservative — we only `set` things that have actually changed
* As much code in the shared library as possible

Given a situation like this...

```html
<Child a={{a}} {{...b_props}} c={{c}} d={{d}} {{...e_props}} />
```

...it should be possible to change any of `a`, `b_props`, `c`, `d` or `e_props` without triggering observers in `Child` for anything else. If `e_props` had (say) a `d` property, and no longer has said property, the `d={{d}}` should take its place in the update — essentially, it should be *as though* we were setting `Object.assign({}, {a}, b_props, {c}, {d}, e_props)`.

I *think* this gets us there:

```js
// this is a shared helper
function get_update(levels, updates) {
	var update = {};

	var to_null_out = {};
	var accounted_for = {};

	var i = levels.length;
	while (i--) {
		var o = levels[i];
		var n = updates[i];

		if (n) {
			Object.keys(o).forEach(key => {
				if (!(key in n)) to_null_out[key] = 1;
			});

			Object.keys(n).forEach(key => {
				if (!accounted_for[key]) {
					update[key] = n[key];
					accounted_for[key] = 1;
				}
			});
			assign(update, n);
			levels[i] = n;
		} else {
			Object.keys(o).forEach(key => {
				accounted_for[key] = 1;
			});
		}
	}

	Object.keys(to_null_out).forEach(key => {
		if (!(key in update)) update[key] = undefined;
	});

	return update;
}


function create_main_fragment(state, component) {
	var child_levels = [
		state.e_props,
		{ d: state.d },
		{ c: state.c },
		state.b_props,
		{ a: state.a }
	];

	var child_data = {};
	var i = child_levels.length;
	while (i--) child_data = assign(child_data, child_levels[i]);

	var child = new Child({
		root: component.root,
		data: child_data
	});

	return {
		c: function create() {
			child._fragment.c();
		},

		m: function mount(target, anchor) {
			child._mount(target, anchor);
		},

		p: function update(changed, state) {
			var child_update = get_update(child_levels, [
				changed.e_props && state.e_props,
				changed.d && { d: state.d },
				changed.c && { c: state.c },
				changed.b_props && state.b_props,
				changed.a && { a: state.a }
			]);

			child._set(child_update);
		},

		u: function unmount() {
			nested._unmount();
		},

		d: function destroy() {
			child.destroy(false);
		}
	};
}
```