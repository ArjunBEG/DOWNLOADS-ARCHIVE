# How to get the latest patch

This little guide describes what to do when:

1. You see a vulnerability warning for a package, and
1. The package has already been fixed, and a [patch version](https://semver.org/) has been released.

## TLDR;

1. Delete all lock files
1. Delete `node_modules`
1. Reinstall

**If you directly depend on the patched library**

You shouldn't need to do anything else. When a library is patched, all dependent libraries will automatically use the patched version, _unless the version was locked_. Thus, make sure the version isn't locked in `package.json` when you reinstall, and you should get the patch.

**If you indirectly depend on the patched library**

You might not need to do anything else, for the same reasons as if you directly depended on the library. However, if intermediate dependency `foo` depends on a locked version of the patched library, you will need to ask the maintainers of `foo` to update the version in the `package.json` of that project so that you can get the fix. 

_Please always check for existing open and/or closed issues on a repository before you create a new one._

Happy patching!