## Tips on debugging "SyntaxError: unexpected token"

> This is almost impossible to write but might as well come up with some possibilities real quick.

### It's an actual syntax error (typo, or just invalid syntax)!

Example:

```js
function a() {
  await 1;
}
```

The above is a syntax error because the code is using await in a regular function, not an async function like  `async function a() {}`.

The nice thing about these kinds of errors is that you can make an issue for them in [babylon](https://github.com/babel/babylon/issues) and maybe contribute a fix! Can similarly do the same for browsers/engines!

### A bug in the tool you are using (eslint, babel, etc)

> You can test this is the case by trying out the syntax in the [Babel REPL](http://babeljs.io/repl), in Node, or the console in your browser.

Don't really need to make an example here: this just means that the parser itself doesn't handle what is actually valid syntax and you can possibly create an issue for it as well.

> For that you may need to check you can update to the latest version of something and see if it fixes it, or if it's fixed in master but not released yet, or someone already made an issue for it.

- The tool isn't "configured" properly

Unfortunately using a tool means some kind of installation, setup, configuration. May need to verify that it's doing it's job; for Babel check that the output is actually compiling. Maybe the config file isn't being picked up, or picking up the wrong one.

These kinds of reports can help inform the maintainers of the kinds of things that kind be done to prevent these issues from happening (of course it's not limited to them to solve though).

### Check aliases for webpack, babel, etc (if you are rewriting your paths somewhere)

### Check that you are running the compiled/built version of the files rather than the source itself.