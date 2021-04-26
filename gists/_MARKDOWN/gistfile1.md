#### The problem:

When writing a React component, you want to target all environments. It is easy to generate a build that will work on the server and browser with Webpack, and as a bonus you can use loaders (like babel-loader for ES6 code).

When you generate this bundle, you should rely on `"react"` as an external so it isn't included in the bundle. In all environments this is desired behavior so you don't duplicate `"react"` and break it. This is necessary both because it would make a much larger bundle than necessary, but also because React behaves badly when multiple copies are loaded.

If you do this, you'll end up with a UMD shim like:

```javascript
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory(require("React"));
	else if(typeof define === 'function' && define.amd)
		define(["React"], factory);
	else if(typeof exports === 'object')
		exports["ReactDraggable"] = factory(require("React"));
	else
		root["ReactDraggable"] = factory(root["React"]);
})(this, function(__WEBPACK_EXTERNAL_MODULE_3__) {
return /******/ (function(modules) { // webpackBootstrap
...
```

See the problem?

Babel now has [a validator for this exact issue](https://babeljs.io/docs/advanced/transformers/validation/react/):

```
The validation.react transformer validates your react imports 
for a non-capitalised module source.

This is necessary as some module bundlers may resolve require("react"); 
and require("React"); to different scripts which will cause two versions 
of react to load that may introduce conflicts.
```

Any user of your library that packages in webpack with `babel-loader` will get this error.

So, that's fine, let's just name it `'react'` - not so fast! Browser builds of React (which are really useful for simple apps or JSFiddle) will break, because your module will try to load `window.react`, which isn't normally exported. You don't want users of your library to have to know this or figure this out.

It turns out, like practically everything Webpack, this is configurable. The [option](https://webpack.github.io/docs/configuration.html#externals):

```
Note: If using umd you can specify an object as external value 
with property commonjs, commonjs2, amd and root to set different 
values for each import kind.
```

So the right configuration is:

```javascript
externals: {
  'react': {
    'commonjs': 'react',
    'commonjs2': 'react',
    'amd': 'react',
    'root': 'React'
  }
},
```

Which generates:

```javascript
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory(require("react"));
	else if(typeof define === 'function' && define.amd)
		define(["react"], factory);
	else if(typeof exports === 'object')
		exports["ReactDraggable"] = factory(require("react"));
	else
		root["ReactDraggable"] = factory(root["React"]);
})(this, function(__WEBPACK_EXTERNAL_MODULE_3__) {
```

This is correct - now you are importing `'react'`, except when importing from the root module where you use the correct `"React"`.