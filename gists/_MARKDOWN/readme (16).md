# A Chromium Compiling Setup for DevTools Hackers

## Instructions:

1. Set the `args.gn` as your gn build configuration
  * Probably best to run `gn args out/Default` and copy/paste what you want to use, then save.
1. `source chromium.sh`
1. `git pull && depsbcr`

That's it.
You can also run the various components of the bash script seperately and together.

* `deps`: run gclient sync to synchronize all the "submodule" dependencies
* `hooks` run gclient hooks, which is otherwise automaticaly run after deps.
* `gom`: initialize goma
* `b`: build/compile chrome
* `cr`: run the built chrome binary

I often do this sequence: `git pull && deps && bcr` followed by hacking followed by `bcr`, `bcr`, `bcr`. However if you're hacking on DevTools, you often don't need to recompile.

## Devtools Debugging

In this config, we've included the `debug_devtools = true` build setting.

* That allows editing *.js and *.css in your working directory and picking up those changes on devtools re-open. (or `alt-r`).  So, after compiling once, you can make JS & CSS edits without recompiling.
* Also, You will also have "Inspect Element" on the devtools itself for self-debugging.

## More 

Please read this doc: [Chrome DevTools Contribution Guide](https://docs.google.com/document/d/1WNF-KqRSzPLUUfZqQG5AFeU_Ll8TfWYcJasa_XGf7ro/view)

### Protips:
* Avoid committing to master: run this in `src/`
  * `curl -fL https://gist.githubusercontent.com/stefansundin/9059706/raw/install-pre-commit.sh | sh`
