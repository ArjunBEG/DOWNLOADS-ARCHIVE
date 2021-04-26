# Convert git-svn tag branches to real tags

**Reference:** http://gitready.com/advanced/2009/02/16/convert-git-svn-tag-branches-to-real-tags.html

This information was found in the article above and has been summarized below!

In the process of converting from Subversion to Git, tags get a bit confused and show up as branches instead once converted over. This can be pretty inconvenient, especially when using `git branch` since a ton of branches would show up such as `tag/1.2`, and so on. A little bit of scripting and Git magic can clear this up easily.

First, use `git svn` to convert your repository. Then, use this script to convert all of the tag branches into **actual tags**, and finally make sure they’re deleted properly:

```
git for-each-ref refs/remotes/origin/tags | cut -d / -f 5- |
while read ref
do
git tag -a "$ref" -m "Say farewell to SVN" "refs/remotes/origin/tags/$ref"
git push origin ":refs/heads/tags/$ref"
git push origin tag "$ref"
done
```