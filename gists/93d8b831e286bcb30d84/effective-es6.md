# Effective transpiling of ES6

After publishing my article on [ECMAScript 6](http://rauchg.com/2015/ecmascript-6/), some have reached out to ask how I exactly I make it all work.

I refrained from including these details on the original post because they're subject to immiment obsoletion. These tools are changing and evolving quickly, and some of these instructions are likely to become outdated in the coming months or even weeks.

## The main tool

When evaluating the available transpilers, I decided to use **6to5**, which has recently been renamed to [Babel](http://babeljs.io). I chose it based on:

- No global object pollution
- Source maps support
- Not being opinionated about polyfills.

The last point is definitely important to me. I pay special attention to the resulting build size, specially when targeting browsers. The ability to choose any polyfill I want pays off.

I use Babel in several ways:

## 0. Hacking ES6 around

If you just want a ES6 REPL:

```bash
npm install -g babel
babel-node
```

will show something like:

![](https://i.cloudup.com/uUo8iSbKXRh/OZCvie.gif)

_Note: if you want to record GIFs like that directly from the terminal, look into my utilty [clif](https://github.com/rauchg/clif)_.

I also set up an alias `es`:

```bash
alias es=babel-node
```

to easily run any file with this wrapper around Node:

```bash
echo "console.log(\`Node version: \${process.version}\`);" > /tmp/template-strings.js
es /tmp/template-strings.js
```

## 1. Writing ES6 Modules

Start with including `babel` in your package.json:

```js
npm install babel --save
```

Notice I didn't use `--save-dev`. Since you might need polyfills, you probably are better off saving Babel as a regular dependency.

It's possible to make ES6 compilation work like CoffeeScript. If you include:

```js
require('babel/register');
```

Subsequent `require` calls will be on-the-fly compiled.
I refrain from doing this because of the runtime execution penalty. I want my ES6 code to run just as fast as my regular code[1].

I set up a `Makefile` task that creates `node/` directory with my build:

```Makefile
BABEL = ./node_modules/.bin/babel

all: node

node: lib
  @mkdir -p node/
  @for path in lib/*.js; do \
    file=`basename $$path`; \
    $(BABEL) "lib/$$file" > "node/$$file"; \
  done
```

and I run this prior to publishing on NPM. My `package.json` `main` points to `node/index`:

```js
{
  "main": "./node/index",
}
```

My `.gitignore` includes `node` and my .npmignore includes `lib`.

At this point you might be concerned about re-running the build and watching directories.
Thankfully, this is not a problem at all for me because I mostly
run my code by triggering tests.

## 2. Writing ES6 tests

Making `mocha` work with ES6 is as easy as creating a file called
`mocha.opts` inside your `test/` directory with the following
contents:

```
--require babel/register
```

This means that you should assume code will be compiled when
`require` is run, like I mentioned above.

When you include your module from the tests, make sure to point
to the source (`lib/`) instead of the compiled version (`node/`):

```js
import myModule from '../lib';
describe('my tests', () => {
  it('is shorter than ES5!', done => {
    setTimeout(done, 500);
  });
});
```

## 3. Writing ES6 browser modules

If you use `browserify`, it's as simple as including
the `babelify` transform:

```bash
npm install babelify --save-dev
browserify -t babelify client/index.js -o public/build.js
```

[1] There's still a performance penalty with [full spec compliance](https://twitter.com/jashkenas/status/568511800209063936). Look into [loose mode](https://babeljs.io/docs/usage/loose/) and benchmark whenever necessary.