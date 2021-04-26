## Goal: TypeScript-style tooling in Svelte

Getting TS in Svelte might be a blocker for some, but I think the underlaying advantage comes in that the TS tools are just a stricter version of the JS tools. Everyone using Svelte gets improvements in tooling from this, not just folks with  TS.

### Three main steps:

1. Migrate [svelte-preprocess](https://github.com/kaisermann/svelte-preprocess/issues) into core (and/or take enough functionality that it's not needed)
2. Create "svelte/svelte-language-tools" repo in main org
   1. Add [`svelte-language-server`](https://github.com/UnwrittenFun/svelte-language-server)
   1. Add [`svelte-vscode`](https://github.com/UnwrittenFun/svelte-vscode)
   1. Create a new `svelte check` tool (or build this into the main CLI) [which uses the LSP to validate](https://github.com/vuejs/vetur/tree/master/vti) - this [makes LSP calls](https://github.com/vuejs/vetur/blob/master/vti/src/cli.ts#L75-L123) against all .svelte files to run TS/JS tooling for errors
3. Do some work on svelte-langauge-server
 
### Rationale

1. This is to allow the editor support to work out of the box, and for a user to be able to safely make assumptions that if they wrote `<script lang="typescript">` (and they have the dep) that it will work.

2. Adding TypeScript support to Svelte can take a lot of tips from prior art done on Vue. 
   [Vetur](https://github.com/vuejs/vetur) acts as the higher level tooling framework for both providing the JS and TS tooling support in scripts. 
   This pattern keeps most of the work in the LSP level, which means all editors can use it, the vscode extension would just be one client of many.
   If folks have other popular IDE integrations, they could live in this repo too.

3. Adds a way to validate on CI, and for folks without the extension. 

### Work on Svelte Lanaguge Server

Luckily, both vscode-svelte and svelte-langauge-server have already been built and worked on by UnwrittenFun and he's interested in moving those to the org.  They both are solid foundations to build upon, from looking through the code.

I think one of the first blockers on making it something recommended by default, is finding a way to make sure that reactive designators are handled in both JS and TS.

Because the `$:` syntax does more work than TypeScript can know about `$: x = count + 1` would probably need transforming into something like `const x = () => { count + 1 }` as an in-memory transform, so that the variables exist in the "TS representation" of the LSP (but not on disk)

### HTMLx

#### The quick route:

I think you can get autocompletion, but I'm not sure how feasible typechecking would be here in a cheap way. 

For inside `{}` the LSP could make API requests to the known script tags above and request all the variables at the top level scope (basically the equivilient of adding a newline in that script and then checking what's available.) 

In theory you could type check each one by making a unique TS document for all of them, with exposed globals from the main script - but that _could_ be quite slow, and it's hard to say how well that could scale.

#### The long route:

Start work on a real LSP for htmlx. 
