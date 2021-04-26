I have a `tsc.js` stack trace, how can I know what is happening?

## Getting `tsc` into a debugger

Normally when you run `npm run tsc` or `yarn tsc` you are running `./node_modules/.bin/tsc`, you can run that same command with 
a debugger attached by running `node --inspect-brk ./node_modules/.bin/tsc` which will launch up and wait for you to attach a debugger.
Running this command should say something like:

> Debugger listening on ws://127.0.0.1:9229/ef185d8c-fbb5-41d9-82ff-926b182cd5c1
> For help, see: https://nodejs.org/en/docs/inspector

Open up a chromium-based browser like Chrome or Node; then go to the developer tools for Node. In Chrome this is `chrome://inspect/#devices`
and in Edge: `edge://inspect`. You should a see a "Remote Target" which you can click "inspect" on. This will open a new window with a paused inspector. Hitting play will start tsc running.

### Debugging tips

To create some kind of repro, you'll have to figure the general area of the problem. This can be done by looking into first which sourcefile the crash has occured from, and then which part of the AST. 

## Source File

If you look at the AST for a TypeScript file - the top of the tree is always [a SourceFile](https://ts-ast-viewer.com/#code/JYWwDg9gTgLgBAbzgQTgXzgMyhEcBEAdAPSYQT4DcAUAKYAekscAxhAHYDO8ARgIZQ4AXjgAKADYQA5lNpQAXCgCUwgHxwADDSA). You may be able to look in the current scope for an AST node which you can start going up the parent tree on till you eventually find the `SourceFile`.

## Logging Closer to the Crash

### Working with a `Type`

Useful: `console.log(type.__debugKind)`

Chances are through you want to go through the `.symbol`  on the `Type` though

### `Symbol`

Using `symbolToString(symbol)` could get you somewhere

### `Node`

A lot of nodes have `.declaration` or `.signature` - from that you can usually get the source code of the node
