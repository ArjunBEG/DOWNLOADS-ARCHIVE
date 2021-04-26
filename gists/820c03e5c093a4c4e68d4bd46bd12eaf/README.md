# WordPress comment classes

Recently, I've endeavored to understand the comment `class="…"` name output from WordPress.

While it's possible to override everything at the theme level, I was curious what WP seems to want to output by default.

To that end, I have attempted to document all the commonalities I could find between the following themes.

- Twenty Twenty
- Twenty Nineteen
- Twenty Seventeen
- Twenty Sixteen

---

Below is an example `*.scss` file, without any styles applied. It just has selectors that one might use, if attempting to style the "standard" output of the most recent default WP themes.

- [_comments.scss](#file-_comments-scss)

---

For reference, I have also included the formatted markup for the comments section from each theme.

If you see any `class="…"` names that are used in all of the themes, feel free to leave a comment and I'll attempt to keep this gist somewhat up to date.

- [comments.twenty-twenty.html](#file-comments-twenty-twenty-html)
- [comments.twenty-nineteen.html](#file-comments-twenty-nineteen-html)
- [comments.twenty-seventeen.html](#file-comments-twenty-seventeen-html)
- [comments.twenty-sixteen.html](#file-comments-twenty-sixteen-html)

---

> ℹ️ NOTE: Some of the inline HTML comments are incorrect. For instance, in Twenty Twenty there is no `class="comments-title"` element but there is a closing `<!-- .comments-title -->` comment. I just left in those types of errors, rather than attempt to gloss over the WP markup output.