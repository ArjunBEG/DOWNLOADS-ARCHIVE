Rollup 0.48 introduces a few changes to the `options` object, because the current options are confusingly different between the CLI and the options exported by your config file.

## Changes to the config file

* `entry` is now `input`
* `sourceMap` and `sourceMapFile` are now `sourcemap` and `sourcemapFile` (note casing)
* `moduleName` is now `name`
* `useStrict` is now `strict`

The `dest` and `format` options are now grouped together as a single `output: { file, format, ... }` object. `output` can also be an array of `{ file, format, ... }` objects, in which case it behaves similarly to the current `targets`. Other output options — `exports`, `paths` and so on — can be added to the `output` object (though they will fall back to their top-level namesakes, if unspecified).

So this...

```js
// old rollup.config.js
export default {
  entry: 'src/main.js',
  dest: 'public/bundle.js',
  format: 'iife',
  moduleName: 'App',
  sourceMap: true
};
```

...would become this:

```js
// new rollup.config.js
export default {
  input: 'src/main.js',
  output: {
    file: 'public/bundle.js',
    format: 'iife',
    name: 'App',
    sourcemap: true
  }
};
```

A config with multiple outputs (say, a CommonJS `main` and a ESM `module` output) might look like this:

```js
import pkg from './package.json';

export default {
  input: 'src/index.js',
  output: [
    { file: pkg.main, format: 'umd', name: 'MyLibrary' },
    { file: pkg.module, format: 'es' }
  ],
  
  // other output options specified here will be shared by
  // all outputs, unless overridden
  sourcemap: true
};
```


## Changes to the API

The same changes apply if you're using the API directly:

```js
rollup.rollup({
  input: 'src/main.js'
}).then(bundle => {
  return bundle.write({
    file: 'public/bundle.js',
    format: 'iife',
    name: 'App',
    sourcemap: true
  });
});
```


## Changes to the CLI

The `--output` and `--format` can now also be specified as `--output.file` and `--output.format` respectively. The shorthand `-o` and `-f` options are unchanged.