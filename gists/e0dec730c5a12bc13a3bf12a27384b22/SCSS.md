[⇐ back to the gist-blog at jrw.fi](http://jrw.fi/)

# Advanced SCSS

Or, **16 cool things you may not have known your stylesheets could do.**  I'd rather have kept it to a nice round number like 10, but they just kept coming.  Sorry.

I've been using [SCSS/SASS](http://sass-lang.com/) for most of my styling work since 2009, and I'm a huge fan of [Compass](http://compass-style.org/) (by the great [@chriseppstein](https://twitter.com/chriseppstein)).  It really helped many of us through the darkest cross-browser crap.  Even though browsers are increasingly playing nice with CSS, another problem has become very topical: managing the complexity in stylesheets as our in-browser apps get larger and larger.  SCSS is an indispensable tool for dealing with this.

This isn't an [introduction to the language](http://sass-lang.com/tutorial.html) by a long shot; many things probably won't make sense unless you have some SCSS under your belt already.  That said, if you're not yet comfy with the basics, check out the awesome CSS extensions you've always wished you had:

 * [Nested selectors](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#css_extensions)
 * [Variables](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#variables_)
 * [Mixins](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#mixins)
 * and loads more

The tips are vaguely ordered from basic to more advanced.  If you're immediately bored, feel free to skip ahead to the deep end of the pool.  Also, if you have any questions, comments or corrections, leave a comment below, or fork this gist and let me know!

So without further ado, on to the *cool things*.

## 1. Prefixing parent selector references

This is the familiar way you're probably using `&`:
```scss
a {
    &:hover {
        color: red;
    }
}
```
```css
/* compiled CSS */
a:hover {
  color: red;
}
```
But `&` can be used with a prefix just as well:
```scss
p {
    body.no-touch & {
        display: none; // hide the message if not on a touch device
    }
}
```
```css
/* compiled CSS */
body.no-touch p {
  display: none;
}
```
This can be very useful when you have a deep nesting of rules, and you want to effect a change to the styling of an element based on a selector match much closer to the DOM root.  Client capability flags such as the [Modernizr](http://modernizr.com/docs/) `no-touch` class are often applied this way to the `<body>` element.  This way you don't have to back out of your nesting just to be able to change your `<p>` styling based on a class on the `<body>`.

## 2. Variable expansion in selectors

Variables can be expanded in selectors, too:
```scss
$alertClass: "error";

p.message-#{$alertClass} {
    color: red;
}
```
```css
/* compiled CSS */
p.message-error {
  color: red;
}
```
...or almost anywhere else for that matter, like in media queries or CSS comments:
```scss
$breakpoint: 768px;

@media (max-width: #{$breakpoint}) {
    /* This block only applies to viewports <= #{$breakpoint} wide... */
}
```
```css
/* compiled CSS */
@media (max-width: 768px) {
  /* This block only applies to viewports <= 768px wide... */
}
```

The media query example is particularly useful if the `$breakpoint` variable is defined in a settings partial somewhere (say, `_settings.scss`), so the breakpoints of the entire application are configurable from one file.

## 3. Variable defaults

If your SCSS module can be configured using globals (which tends to be the SCSS way), you can declare them with a default value:
```scss
// _my-module.scss:
$message-color: blue !default;

p.message {
    color: $message-color;
}
```
```css
/* compiled CSS */
p.message {
  color: blue;
}
```
But you can then optionally override the module defaults before its inclusion:
```scss
$message-color: black;
@import 'my-module';
```
```css
/* compiled CSS */
p.message {
  color: black;
}
```
That is, an assignment with a `!default` will only take effect if such a variable didn't have a value before (in contrast to the standard assignment, which will always overwrite a possible previous value).

This is how many SCSS modules (including most that ship with Compass) are configured.

## 4. Control directives

SCSS sports the standard set of flow control directives, such as `if`:
```scss
$debug: false; // TODO: move to _settings.scss

article {
    color: black;

    @if ($debug) { // visualizing layout internals
        border: 1px dotted red;
    }
}
```
```css
/* compiled CSS */
article {
  color: black;
}
```
Having such compile-time flags in your project's styling can help debug complex layout issues visually, faster than just inspecting the page an element at a time.

There's also `@for`, `@each` and `@while`.  They're good for a number of use cases that would otherwise need lots of repetitive (S)CSS, like:
```scss
@each $name in 'save' 'cancel' 'help' {
    .icon-#{$name} {
        background-image: url('/images/#{$name}.png');
    }
}
```
```css
/* compiled CSS */
.icon-save {
  background-image: url("/images/save.png");
}
.icon-cancel {
  background-image: url("/images/cancel.png");
}
.icon-help {
  background-image: url("/images/help.png");
}
```
...and much more.  Keep in mind, though, that if you need them in your daily styling work you're probably overdoing it a bit.  Instead, the added complexity is usually justified when building configurable SCSS modules and such.

The interested reader can check out the [full documentation on control directives](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#control_directives).

## 5. The list data type

As we saw in the previous example, `@each` can iterate over a list.  Lists are in fact a [fundamental part](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#lists) of the SCSS language, but a quick demonstration of their usefulness might be configuring some generated styling:
```scss
$buttonConfig: 'save' 50px, 'cancel' 50px, 'help' 100px; // TODO: move to _settings.scss

@each $tuple in $buttonConfig {
    .button-#{nth($tuple, 1)} {
        width: nth($tuple, 2);
    }
}
```
```css
/* compiled CSS */
.button-save {
  width: 50px;
}
.button-cancel {
  width: 50px;
}
.button-help {
  width: 100px;
}
```
This demonstrates two features of the list data type, namely the `nth()` [list accessor function](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html#nth-instance_method), and more interestingly list nestability: in JavaScript notation, the above would be equivalent to:
```js
var buttonConfig = [[ 'save', 50 ], [ 'cancel', 50 ], [ 'help', 100 ]];
```
That is, lists can be separated by both spaces and commas, and alternation between the two notations produces nested lists.

## 6. Defining custom functions

[Mixins](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#mixins) are a well-known part of the language, but SCSS also allows you to define custom functions.  Contrary to what one might expect, this can also be done in pure SCSS, instead of [extending SCSS in Ruby](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html#adding_custom_functions):
```scss
@function make-greener($value) {
    @return $value + rgb(0,50,0); // arithmetic with colors is totally fine, btw
}
p {
    background: make-greener(gray);
}
```
```css
/* compiled CSS */
p {
  background: #80b280;
}
```
The above color is a gray with a slight green tint.

Custom functions are most useful in avoiding some repeated computation in an expression.  It also implicitly documents that computation by giving it a name: the above example, while contrived, is still more understandable than just having arbitrary color arithmetic in the style block.  SCSS ships with a ton of [useful built-in functions](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html), and Compass [adds even more](http://compass-style.org/reference/compass/helpers/), so do first check whether there's a built-in equivalent before implementing your own.

## 7. Argument defaults

Mixins and functions support default values for arguments; the *last* zero-to-N arguments can be made optional by providing them with a default value:
```scss
@mixin foobar($a, $b, $padding: 20px) {
    padding: $padding;
    // ...and something with $a and $b
}

p {
    @include foobar(123, "abc"); // the default padding's fine
}

p.important {
    @include foobar(123, "abc", 50px); // override the default
}
```

## 8. Keyword arguments

If your mixin (or function) takes *a lot* of arguments, there's a similar call-time syntax for selecting specific arguments to override:
```scss
@mixin foobar($topPadding: 10px, $rightPadding: 20px,
    $bottomPadding: 10px, $leftPadding: 20px, $evenMorePadding: 10px) {
    // do something with all these arguments...
}

p {
    @include foobar($bottomPadding: 50px);
}
```
Without being able to name arguments call-time, you'd have to specify `$topPadding` and `$rightPadding` first.  Now, you can instead override *only* the argument you want, leaving the rest to their default values.

Note, however, that in cases where a lot of the arguments are just for overriding specific CSS properties (such as `top-padding`, `bottom-padding` and so on), the "content block overrides" -pattern is likely a better fit (see below).

## 9. Variable arguments for functions/mixins

[Var-args](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#variable_arguments) work much the same way as in other languages that support the feature; any extra arguments to a function/mixin call are wrapped into a list and assigned to the argument having a `...` suffix:

```scss
@mixin config-icon-colors($prefix, $colors...) {
    @each $i in $colors {
        .#{$prefix}#{nth($i, 1)} {
            color: nth($i, 2);
        }
    }
}
@include config-icon-colors('icon-',
    'save'   green,
    'cancel' gray,
    'delete' red
);
```
```css
/* compiled CSS */
.icon-save {
  color: green;
}
.icon-cancel {
  color: gray;
}
.icon-delete {
  color: red;
}
```

The above helper could be used to set up colors for your font icons, [Font Awesome](http://fortawesome.github.io/Font-Awesome/) for example, without having to repeat yourself.  The helper works by passing in a variable number of arguments (after the first, required one).  Each of those arguments is expected to be a tuple of two items (again in JavaScript notation, for example `[ "save", "green" ]`).

In fact, the `...` syntax also works during call-time, where it expands a list into separate arguments, to be fed into the target mixin:

```scss
@mixin foobar($a, $b, $c) {
    // receives args $a = 5px, $b = red, and so on
}

$myArgs: 5px red "bla bla";
// at this point, you could also programmatically add/remove arguments

@include foobar($myArgs...);
```

Personally, I have yet to find a use case for this, but [the documentation](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#variable_arguments) has a nice use case for passing current arguments forward to another mixin.

## 10. Content block arguments for mixins

Since [version 3.2.0](http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html#320_10_august_2012), SCSS has had an implicit mixin argument accessible through the `@content` directive.  It allows passing an entire SCSS content block as an argument to the mixin:

```scss
@mixin only-for-mobile {
    @media (max-width: 768px) {
        @content;
    }
}

@include only-for-mobile() /* note: @content begins here */ {
    p {
        font-size: 150%;
    }
} /* @content ends */
```
```css
/* compiled CSS */
@media (max-width: 768px) {
  p {
    font-size: 150%;
  }
}
```

This is a *very* powerful language feature for framework authors, as it allows you to pass arbitrary blocks of styling around, which you can choose to wrap in specific selectors, repeat in loops, make conditional with `@if`, etc.  You can mix standard and content block arguments, too:

```scss
@mixin only-for-mobile($breakpoint) {
    @media (max-width: #{$breakpoint}) {
        @content;
    }
}

@include only-for-mobile(480px) {
    p {
        font-size: 150%;
    }
}
```

## 11. Content block overrides -pattern

Consider a mixin that generates a selector and some styles for it, allowing the caller to customize the styling if needed:
```scss
@mixin message($class, $color: yellow, $margin: 20px, $padding: 10px) {
    .message-#{$class} {
        border: 1px dotted $color;
        color: $color;
        margin: $margin;
        padding: $padding;
    }
}
```
Calling this mixin using keyword arguments (see above) is quite convenient, because if the defaults are fine, no extra arguments need be provided.  If they're not, you only need to specify the arguments you want to override:
```scss
@include message("subtle", $margin: 5px);
```
But this requires you to list *all overridable properties* in the mixin signature.  However, content block arguments allow arbitrary overrides without the argument jungle:
```scss
@mixin message($class) {
    .message-#{$class} {
        border: 1px dotted yellow;
        color: yellow;
        margin: 20px;
        padding: 10px;
        @content;
    }
}

@include message("subtle") {
    margin: 5px;
}
```
```css
/* compiled CSS */
.message-subtle {
  border: 1px dotted yellow;
  color: yellow;
  margin: 20px;
  padding: 10px;
  margin: 5px;
}
```
Here, we allow the good-ole CSS cascade to effect the property override (the latter `margin` overrides the former one).  Also, we're not limited to overriding the properties the author of the mixin thought of.  In fact, this allows passing in nested blocks as well:
```scss
@include message("actionable") {
    button { // actionable messages may contain buttons for taking action!
        float: right;
    }
}
```
```css
/* compiled CSS */
.message-actionable {
  border: 1px dotted yellow;
  color: yellow;
  margin: 20px;
  padding: 10px;
}
.message-actionable button {
  float: right;
}
```
This pattern can be useful in any library code that outputs nontrivial styling with generated selectors, since it allows the user a customization point beyond what the library author foresaw.  Note, though, that in simple cases (where no selectors are emitted within the mixin) it's rather unnecessary, as any overrides can be made just using the standard CSS cascade.

## 12. Media query bubbling

`@media` blocks do not need to be declared at the root level of the stylesheet:
```scss
body {
    article {
        p {
            font-size: 100%;
            color: black;
            padding: 10px;

            @media (max-width: 768px) {
                font-size: 150%; // use larger text for smaller screens
            }
        }
    }
}
```
```css
/* compiled CSS */
body article p {
  font-size: 100%;
  color: black;
  padding: 10px;
}

@media (max-width: 768px) {
  body article p {
    font-size: 150%;
  }
}
```
Notice how the compiler "bubbles up" the `@media` block to the root level (since regular CSS doesn't support selector nesting), and within it, outputs all styling that was encountered within the `@media` block in the SCSS source.

This is very useful as it allows you to make media-specific tweaks almost anywhere in your styling, right where they're relevant, instead of collecting all those tweaks to the end of the stylesheet, and hoping that their selectors will stay in sync with the ones they're overriding (they won't).

## 13. Media query nesting

The aforementioned bubbling mechanism also takes nesting into account, and combines all applicable queries with the `and` operator:
```scss
p {
    @media (max-width: 768px) {
        font-size: 150%; // use larger text for smaller screens
        @media (orientation: landscape) {
            line-height: 75%; // condense text a bit because of small vertical space
        }
    }
}
```
```css
/* compiled CSS */
@media (max-width: 768px) {
  p {
    font-size: 150%;
  }
}
@media (max-width: 768px) and (orientation: landscape) {
  p {
    line-height: 75%;
  }
}
```

## 14. Extending selectors

SCSS allows [extending selectors](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend), by copying and combining selectors in the CSS output.  Interestingly, while the mechanism is (obviously) very different, the semantics of `@extend` are quite analogous to traditional object-oriented programming languages (such as Java & whatnot):
```scss
.animal {
    background: gray;
}
.cat {
    @extend .animal;
    color: white;
}
```
```css
/* compiled CSS */
.animal, .cat {
  background: gray;
}
.cat {
  color: white;
}
```
That is, `.cat` has all the properties of its "parent class" `.animal`, plus any specific ones it adds or overrides.  Whereas in normal CSS you would have to reference both the extending class and the parent class (e.g. `<div class="animal cat">`), now you can just name the exact class you want (`<div class="cat">`).  What it does (or doesn't) inherit from depends on the definition of `.cat`, and can later change without touching the markup.

Classical inheritance, right?  Overriding properties in the "child class" works due to the style cascade in the browser: styling for the same selector that comes later in the file always wins over the styling that came before it.  Perhaps a bit unintuitively, this actually works out fine even if the combined selectors have differing [specificity](http://www.w3.org/TR/css3-selectors/#specificity) (think `.class` extending an `#id`).  Extending selectors may often be preferable to using mixins to achieve the same effect:
```scss
@mixin animal {
    background: gray;
    border: 1px solid red;
    font-weight: bold;
    font-size: 50px;
    color: red;
    padding: 20px;
}
.cat {
    @include animal;
    color: white;
}
.dog {
    @include animal;
    color: black;
}
```
```css
/* compiled CSS */
.cat {
  background: gray;
  border: 1px solid red;
  font-weight: bold;
  font-size: 50px;
  color: red;
  padding: 20px;
  color: white;
}
.dog {
  background: gray;
  border: 1px solid red;
  font-weight: bold;
  font-size: 50px;
  color: red;
  padding: 20px;
  color: black;
}
```
Notice how only the last property (`color`) is different, the rest is the same.  As we define more types of animals, the amount of repeated style properties in the CSS output keeps growing.  This is in contrast to how selector extension would solve the same problem:
```scss
.animal {
    background: gray;
    border: 1px solid red;
    font-weight: bold;
    font-size: 50px;
    color: red;
    padding: 20px;
}
.cat {
    @extend .animal;
    color: white;
}
.dog {
    @extend .animal;
    color: black;
}
```
```css
/* compiled CSS */
.animal, .cat, .dog {
  background: gray;
  border: 1px solid red;
  font-weight: bold;
  font-size: 50px;
  color: red;
  padding: 20px;
}
.cat {
  color: white;
}
.dog {
  color: black;
}
```
Finally, selector extension allows for integrations into 3rd party CSS libraries, that need not be specifically designed for extension, or even be written in SCSS.  [Twitter Bootstrap](http://twitter.github.io/bootstrap/), for example, includes nice styling for buttons with `.btn`, but doesn't apply it to `<button>` elements by default.  In our quest to reduce unnecessary CSS classes, we can fix this simply with:
```scss
@import "bootstrap.scss"; // just a renamed .css file, so that @import works

button {
    @extend .btn;
}
```
This will add the `button` selector into the Bootstrap source wherever `.btn` is defined.

The extension mechanism is surprisingly clever even with [more complex selectors](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extending_complex_selectors), and allows [chaining extends](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#chaining_extends) (think `.cat` extends `.feline` extends `.animal`), but with great power comes great responsibility: overly [neat tricks](http://thedailywtf.com/Articles/Classic-WTF-Now-Thats-A-Neat-Trick.aspx) with `@extend` may be hard to reason about when debugging styles.  Use responsibly.

## 15. Placeholder selectors

Because in the above example(s) the `.animal` base class isn't used anywhere directly (only through its child classes), we might just as well get rid of it in the CSS output.  SCSS allows this with [placeholder selectors](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#placeholders).  Whereas `.foo` signifies a class, and `#foo` an ID, `%foo` is considered a placeholder, and gets special treatment by the compiler: its styles are never output on their own, only through extension.
```scss
%animal {
    background: gray;
    // and so on...
}
.cat {
    @extend %animal;
    color: white;
}
.dog {
    @extend %animal;
    color: black;
}
```
```css
/* compiled CSS */
.cat, .dog {
  background: gray;
}
.cat {
  color: white;
}
.dog {
  color: black;
}
```
Because `%animal` was just a placeholder selector, it's disappeared from the output.  More importantly, if you never define a selector that extends `%animal`, its styles (`background: gray;` and so on) are completely omitted from the output.  This can be very useful for SCSS framework authors, as you can offer any number of base classes for opt-in extension, but only the ones actually *used* are output into the resulting CSS.

Placeholder selectors can actually do even more than this, namely expanding the `%placeholder` part into a more complex selector during `@extend`, but personally I've never had to use this feature.  The interested reader can check out the [docs on the subject](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#placeholders).

## 16. Selector multiple inheritance

A selector can actually inherit from *several* other selectors - that is, SCSS supports multiple inheritance.  For each `@extend`, the current selector is appended to the selector being extended.  When combined with placeholder selectors, this allows powerful abstractions for styling framework authors.  This is perhaps best explained through an example:
```scss
// in the framework files:
%mfw-standing-out {
    font-size: 150%;
    font-style: italic;
    padding: 25px;
}
%mfw-slightly-shadowed {
    @include box-shadow(black 2px 2px 10px); // from Compass
}
%mfw-rounded {
    @include border-radius(25px); // from Compass
}

// in the application files:
#join-button {
    @extend %mfw-standing-out;
    @extend %mfw-slightly-shadowed;
    @extend %mfw-rounded;
    background: green;
    color: white;
}
```
This way of constructing styling has a few notable benefits:

 * **Self-documentation:** Instead of writing out loads of anonymous style properties, the author instead lists the "traits" of the UI component he is designing.  The names of the traits can be as long & descriptive as needed (they won't appear in the CSS output).
 * **Naming isolation:** The application can use whichever naming conventions and semantics in the HTML, while the framework naming conventions stay internal to the SCSS source.  In the above example, the framework adopts a common prefix `%mfw` (for "my framework", or whatever) to avoid naming collisions with other SCSS libraries.
 * **Reduced repetition:** The `#join-button` could use the `border-radius()` and `box-shadow()` helpers directly to achieve the same stylistic effect.  But for each additional component that does so, the `box-shadow()` helper would output the exact same lines of CSS, with all the vendor prefixes and whatnot.  Extending `%mfw-slightly-shadowed`, however, would simply append the selector to the list of other selectors that should receive shadowing.
 * **Opt-in:** If a specific "trait" is never used to describe a UI component, its styles are never output.  That is, if you just use 1% of the features of a bloated style framework, your CSS payload will only contain that 1%.  Contrast this to the de-facto way of just including an entire Bootstrap or jQuery, because the site uses 1 or 2 features from each.

Potential downsides with this approach should be kept in mind:

 * **Debuggability:** Without properly configured [source maps for SCSS](http://bricss.net/post/33788072565/using-sass-source-maps-in-webkit-inspector), it may be harder to figure out how some styling ended up affecting a specific element (keeping in mind the above point about *self-documentation* no longer applies in the compiled CSS).
 * **Arguments:** This technique won't replace mixins when computation is required based on some arguments.  While there can be several versions of each "trait" (think `%mfw-slightly-shadowed` vs `%mfw-heavily-shadowed`), they'll always be completely static in content.

## And that's it

Hope you picked up something useful!

There may be more at [my site](http://jrw.fi/) or [@jareware](https://twitter.com/jareware), depending on when you look. :)

Cheers,

\- Jarno

![GA](https://ssl.google-analytics.com/__utm.gif?utmwv=5.4.3&utmn=47004&utmhn=gist.github.com&utmdt=Advanced%20SCSS%2C%20or%2C%2016%20cool%20things%20you%20may%20not%20have%20known%20your%20stylesheets%20could%20do&utmr=-&utmp=%2Fjareware%2F4738651&utmac=UA-42176157-3&utmcc=__utma%3D1.1828258468.1374783534.1374783534.1374783534.1%3B%2B__utmz%3D1.1374783534.1.1.utmcsr%3D(direct\)%7Cutmccn%3D(direct\)%7Cutmcmd%3D(none\)%3B)
