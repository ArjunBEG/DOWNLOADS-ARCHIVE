>**Note:**
>
>When this guide is more complete, the plan is to move it into Prepack documentation.  
>For now I put it out as a gist to gather initial feedback.

# A Gentle Introduction to Prepack (Part 1)

If you're building JavaScript apps, you might already be familiar with some tools that compile JavaScript code to equivalent JavaScript code:

* [Babel](http://babeljs.io/) lets you use newer JavaScript language features, and outputs equivalent code that targets older JavaScript engines.

* [Uglify](https://github.com/mishoo/UglifyJS) lets you write readable JavaScript code, and outputs "mangled" JavaScript that does the same thing, but contains fewer bytes.

**Prepack** is yet another tool that aims to compile JavaScript to equivalent JavaScript code. But unlike Babel or Uglify, Prepack isn't focused on new features or code size.

**Instead, Prepack lets you write normal JavaScript code, and outputs equivalent JavaScript code that runs faster.**

If this sounds exciting, read on to learn how Prepack works and how you can make it better.

## What’s in This Guide?

Personally, when I finally understood what Prepack can do, I was excited. I thought that in the long term Prepack could solve many problems that I encountered building large JavaScript apps. I wanted to spread the word about it, and get other people excited about it too.

However, Prepack can be intimidating to contribute to at first. Its source code contains many terms that I wasn't familiar with, and it took me a while to understand what Prepack does. Compiler codebases tend to use established Computer Science terminology, but it turned out that many of these concepts sounded more difficult than they actually were.

**I wrote this guide for JavaScript developers who don't necessarily have a Computer Science background, but are excited by the promise of Prepack and want to help make it a reality.**

This guide provides a high-level overview of how Prepack works, and gives you a starting point for contributing. Many concepts in Prepack directly map to the tools you're relying on every day in JavaScript code: objects, properties, conditions, and loops. Even if you can't use Prepack for your projects just yet, you might discover that working on Prepack enriches your understanding of the JavaScript code you're writing every day.

## Before We Dive In 🚧

Note that Prepack is **not yet ready for mainstream adoption**. You cannot just plug it into your build system like you do with Babel or Uglify, and expect it to work. Instead, you can think of Prepack as an ongoing and ambitious experiment that you can participate in, and that will hopefully become useful to you in the future. Because of its vast scope, there are still many opportunities to improve it.

Now, this doesn't mean that Prepack *doesn't work*. But it's currently focused on a very narrow set of scenarios, and it might have more bugs than most people would be comfortable with in production. The good news is you can help Prepack support more use cases, and help fix the bugs in it. This guide will help you get started.

## Prepack Fundamentals

Let's recap the Prepack mission statement that I mentioned earlier:

>Prepack lets you write normal JavaScript code, and outputs equivalent JavaScript code that runs faster.

Why don't we just write faster code in the first place? We can certainly try, and we should when we can. However, in many apps, aside from the bottlenecks identified by profiling, there isn't anything obvious to optimize next.

Often there's no single place where the program is slow; instead, the program suffers from a "death by a thousand cuts". Features that encourage separation of concerns, such as function calls, allocating objects, and various abstractions, eat away at the runtime performance. However, getting rid of them in the source code would make it unmaintainable, and there is no easy "fix" we could apply to microoptimize them either. Even JavaScript engines with years of optimization work are limited in what they can do, especially for initialization code that only runs once.

**The surest way to improve performance is to do less work. Prepack takes this principle to its logical conclusion: it executes the program _at the build time_ to learn what the code _would_ do, and then generates the equivalent code that does the same with the least computations.**

This sounds pretty magical so let's consider a few examples and see Prepack's strengths and limitations. We will use [Prepack REPL](https://prepack.io/repl.html) which lets us run Prepack on a piece of code online.

### Two Ways to Calculate 2 + 2

Let's start by opening [this example](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1oG4CGATmgB5oC8aATANw77FoCelN9uA5gDYIBGBbgDoCEAM4B3AKYkq5ANQt6AXxSp6QA):

```js
(function() {
  var x = 2;
  var y = 2;
  global.answer = x + y;
})();
```

The output is:

```js
answer = 4;
```

Indeed, running both snippets produces the same observable effect: the value `4` is assigned to a global variable called `answer`. However, the Prepacked version doesn't contain the code that calculates `2 + 2`. Instead, Prepack ran `2 + 2` during compilation, and *"serialized"* (a fancy way of saying "wrote" or "emitted") the final assignment operation.

This isn't very impressive by itself: for example, [Google Closure Compiler can also turn `2 + 2` into `4`](https://closure-compiler.appspot.com/home#code%3D(function()%2520%257B%250A%2520%2520var%2520x%2520%253D%25202%253B%250A%2520%2520var%2520y%2520%253D%25202%253B%250A%2520%2520global.answer%2520%253D%2520x%2520%252B%2520y%253B%250A%257D)()%253B). This optimization is called ["constant folding"](https://en.wikipedia.org/wiki/Constant_folding). What sets Prepack apart is that **it can execute arbitrary JavaScript code, not just constant folding or similar limited optimizations.** Prepack also has its own limitations which we'll get to a bit later.

Consider this intentionally obtuse and incredibly convoluted way to calculate `2 + 2`:

```js
(function() {
  function getNumberCalculatorFactory(injectedServices) {
    return {
      create() {
        return {
          calculate() {
            return injectedServices.operatorProvider.operate(
              injectedServices.xProvider.provideNumber(),
              injectedServices.yProvider.provideNumber()
            )
          }
        };
      }
    }
  }
  
  function getNumberProviderService(number) {
    return { provideNumber() { return number; } };
  }

  function createPlusOperatorProviderService() {
    return { operate(x, y) { return x + y; } };
  }  
  
  var numberCalculatorFactory = getNumberCalculatorFactory({
    xProvider: getNumberProviderService(2),
    yProvider: getNumberProviderService(2),
    operatorProvider: createPlusOperatorProviderService(),
  });

  var numberCalculator = numberCalculatorFactory.create();
  global.answer = numberCalculator.calculate();
})();
```


While we don't recommend writing code for summing up two numbers this way, you can see that [Prepack produces the same exact output](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1vNeJNAcwFMYA5MAWwCNSAnAYQEMAbKMNlmBBgMRaw+AT2BwIAK1KxSAEwDKjAG5wopAM7psuXA3JgGETDl24o+nqVQmzZ-TEPGdds1HaduMa9tOv7BkZoEtKyiipqmgB0CAAOjDx8AAoMCKpyjDHxDFbAfv5mITLe4Qyq6hpRAB4paXAZDFGxqemkVHSMqAA0+QW4RWFKZZGVIrWtjc11Ge30DKi9-iiLZgC+K2irANyL62ume2im+LCIxmSUNHPj9YxD5dYQV4y+AY5BGGhTrbOd2mgOJxoJ4dBhbTabHa4dbHSCnIgWUhWJJsMAaADy2USDBuDXukRsLj0gWcaDiCW8wCqXTQIn+gKCVTQAGpaeDVpCDrhTKZlCwGMDnswPFxsYJhAwRGgALwkci-YUcUW8ARCFViIloGotW4MABccsuoNxdwi6mAACYUD0zGMdQ0DRcFSaGPjzVabbpyTkVS6DYjkaiMVjffbTcNzdaDigdrz+YLQawlV4+DKE3Mk54xWrRFEA5SY6ZiGwELR2FEWBANAB3RhpkEZkUpxruZO5QurFCoLZAA) for it:

```js
answer = 4;
```

In both cases, Prepack has **executed** the code above at the build time to calculate the observable **"effects"** (changes) it had on the environment (e.g. setting a global called `answer` to `4`), and then **"serialized"** (wrote) the code that produces the same effects with minimal runtime overhead.

The same higher-level picture is true for any code that runs through Prepack.

### Side Note: How Does Prepack Execute My Code?

"Executing" code at the build time sounds scary. You wouldn't want Prepack to remove a file from your system just because your input code contains an `fs.unlink()` call.

We need to clarify that Prepack doesn't just `eval` the input code in a Node environment. Instead, **Prepack includes an implementation of a complete JavaScript interpreter** so it can execute arbitrary code in an "empty" isolated environment. By default, it doesn't have support for Node primitives like `require()`, `module`, or browser primitives like `document`. We'll get back to these limitations later.

This doesn't, however, mean that building a bridge between the "host" Node environment and the Prepack JS environment is impossible. In fact [it may be an interesting idea to explore in the future](https://github.com/facebook/prepack/issues/644). Perhaps you'll be the one to do it?

### A Tree Falls in a Forest

You might have heard this philosophical question:

>If a tree falls in a forest and no one is around to hear it, does it make a sound?

It turns out that it is directly relevant to what Prepack can and cannot do.

Consider [this slight variation of the first example](https://prepack.io/repl.html#G4QwTgBAHhC8ECYDcAoUkCedGoOYBsB7AIxHwDoQA7AZwHcBTSeGAagg1SA):

```js
var x = 2;
var y = 2;
global.answer = x + y;
```

The output, perhaps surprisingly, contains the definitions for `x` and `y` too:

```js
var y, x;
x = 2; // Why did this get serialized?
y = 2; // Why did this get serialized?
answer = 4;
```

This is because Prepack treats the input code as a script (rather than a module). **A `var` declaration outside a function [becomes a global variable](http://speakingjs.com/es5/ch16.html#_global_variables),** so from Prepack's point of view it would be as if we explicitly assigned them to globals:

```js
var x = 2; // Same as: global.x = 2;
var y = 2; // Same as: global.y = 2;
global.answer = x + y;
```

That's why Prepack kept `x` and `y` in the output. Don't forget the goal of Prepack is to produce equivalent code, and it doesn't protect you from JavaScript's pitfalls.

The easiest way to protect against this mistake is to **always wrap the Prepacked code into an [IIFE](http://speakingjs.com/es5/ch16.html#iife), and explicitly attach the results you need to keep to a global:**

```js
(function() { // Create a function scope
  var x = 2; // Not a global variable anymore
  var y = 2; // Not a global variable anymore
  global.answer = x + y;
})(); // Don't forget to call it!
```

This [produces the expected output](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1oG4CGATmgB5oC8aATANw77FoCelN9uA5gDYIBGBbgDoCEAM4B3AKYkq5ANQt6AXxSp6QA):

```js
answer = 4;
```

Here is [another potentially confusing example](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1oG4CGATmgB5oC8aATANw77FoCelN9uhJBEAzgO4BTElWpoA1OywBfFKlpA):

```js
(function() {
  var x = 2;
  var y = 2;
  var answer = 2 + 2;
})();
```

The Prepack REPL outputs a helpful warning for it:

```js
// Your code was all dead code and thus eliminated.
// Try storing a property on the global object.
```

Here, the opposite happened: **even though we performed some computation, nothing we calculated has any "effects" on the environment.** If some other script ran later, it would have no way to determine whether our code ran at all. Therefore, there is no need to serialize any of these values.

Again, to fix this we'd need to explicitly mark what we **want** to keep by putting it on a global object, and let Prepack eliminate the rest:

```js
(function() {
  var x = 2; // Prepack can discard this variable
  var y = 2; // Prepack can discard this variable
  global.answer = 2 + 2; // But this value needs to be serialized
})();
```

Conceptually, this may remind you of [garbage collection](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management#Garbage_collection): objects that are "reachable" from a global object need to "stay alive" (or, in case of Prepack, get serialized). There are also other kinds of "effects" that Prepack supports aside from setting global properties, but we'll look at them later.

### Residual Heap

Now we know enough to roughly describe how Prepack works.

As Prepack interprets the input code, it builds up internal representations of all objects used in the program. For every JavaScript value (an object, a function, a number) there is an internal Prepack object that contains information about it. The Prepack codebase contains classes like `ObjectValue`, `FunctionValue`, `NumberValue`, and even `UndefinedValue` and `NullValue`.

Prepack also keeps track of all the **effects** (such as writing a global) that the input code could have had on the environment. In order to faithfully reproduce these effects in the output code, Prepack finds all values that are still "reachable" from a global object after the code has finished running. In the example above, `global.answer` is considered "reachable" because unlike local variables `x` and `y`, external code could read `global.answer` in the future. This is why it would be unsafe to omit `global.answer` from the output, but safe to omit `x` and `y`.

All values reachable from the global objects (and thus potentially affecting the code that runs later) are collectively called **"residual heap"**. This name sounds more complex than the idea itself. The "residual heap" is a part of the "heap" (all objects created by the executed code) that stays as a "residue" (i.e. is left in the output) after the code has finished executing. If we take off our Computer Science hats, we could call it the "leftover stuff".

### Serializer

So how does Prepack produce the output code?

After Prepack has marked all "reachable" values as being in the residual heap, it then runs a **serializer** on them. The job of the serializer is to figure out how to turn Prepack's object representations for JavaScript objects, functions, and other values on the residual heap, into the output code.

If you're familiar with `JSON.stringify()`, conceptually you can think of Prepack serializer as doing something similar. However, `JSON.stringify()` has the luxury of avoiding complex cases like circular references between objects:

```js
var a = {};
var b = {};
a.b = b;
b.a = a;
var x = {a, b};
JSON.stringify(x); // Uncaught TypeError: Converting circular structure to JSON
```

JavaScript programs have circular references between objects very often so Prepack serializer has to support all of those cases, and emit correct equivalent code to rebuild those objects. So [for an input like this](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1oG4CGATmgWgLyYC+A3DvsWgEYXV24EB0LlT7znMpQL8A5gBsETAuM4APVhgIAaZrSxUUqGkA):

```js
(function() {
  var a = {};
  var b = {};
  a.b = b;
  b.a = a;
  global.x = {a, b};
})();
```

Prepack generates code like this:

```js
(function () {
  var _2 = { // <-- b
    a: void 0
  };
  var _1 = { // <-- a
    b: _2
  };
  _2.a = _1;
  x = {
    a: _1,
    b: _2
  };
})();
```

Note that the assignment order is different (the input code constructed `a` first, but the output code started with `b`). This is because in this case the assignment order doesn't matter. However, this illustrates the core principle of how Prepack works:

**Prepack doesn't _transform_ the input code. Instead it _executes_ the input code, finds all values in the *residual heap*, and then *serializes* these values and the *effects* that use them, into the output JavaScript code.**

### Side Note: Isn't Putting Things on a Global Bad?

The examples above might make you wonder: isn't it a bad practice to put values onto globals? It generally *is* in production code, but if you're using an experimental JavaScript abstract interpreter that isn't production-ready in production, you might have bigger issues to worry about.

There is a limited support for running Prepack in a CommonJS-like environment with `module.exports`, but it's currently very ad-hoc (and is implemented via a global anyway). In either case, this is not very important yet because it doesn't fundamentally change how the code executes, and will become more pressing only when Prepack is more ready to integrate with other tools.

### Residual Functions

Let's say we wanted to add some encapsulation to our code, and wrapped the `2 + 2` calculation into a function:

```js
(function () {
  global.getAnswer = function() {
    var x = 2;
    var y = 2;
    return x + y;
  };
})();
```

If you [try to compile this](https://prepack.io/repl.html#BQMwrgdgxgLglgewgAmASmQbwFDOQcwBsEAjAQ0IDp8BTGAQQgGcB3GgJ2QF5lxp4k6LLjzIAbmU4APbsgBMAbhF4JnAJ6zFy5Ozph2KGQGpkapXgC+Si2nRLsQA), you might be surprised by the result:

```js
(function () {
  var _0 = function () {
    var x = 2;
    var y = 2;
    return x + y;
  };

  getAnswer = _0;
})();
```

It looks like Prepack didn't optimize our calculation! Why is that?

**By default, Prepack only optimizes the "initialization path" (the code that executes immediately).**

From Prepack's point of view, the program has finished when Prepack has executed all statements in it. The effect of the program is to set a global variable called `getAnswer` to a function that we wrote, which Prepack did. As far as it's concerned, the work is over.

If we called `getAnswer()` before exiting the program then Prepack would execute it. Whether or not `getAnswer()` implementation would stay in the output depends on whether or not the function itself is "reachable" from the global object (and thus would be unsafe to omit). Functions that are emitted in the output are called **"residual functions"** (they are "residue", or leftovers, in the output).

By default, Prepack will *not* attempt to execute or optimize residual functions. It's not generally safe. By the time a residual function gets called from the outside code, both JavaScript runtime globals like `Object.prototype` and objects created by the input code could have been mutated without Prepack's knowledge. Then Prepack would either have to use potentially stale values captured in its residual heap, differing in behavior from the original code, or always assume that *anything* can get mutated, making the optimization too difficult. Neither is desirable so residual functions stay intact.

There is, however, an experimental mode which lets you opt into optimizing certain functions, and we will cover it in a later section.

### Speed vs. Size Tradeoff

Consider this example:

```js
(function () {
  var x = 2;
  var y = 2;

  function getAnswer() {
    return x + y;
  };
  
  global.getAnswer = getAnswer;
})();

```

Prepack [emits the following code](https://prepack.io/repl.html#BQMwrgdgxgLglgewgAmASmQbwFDOQNwEMAnZAD2QF5kAmAblwJOQE8raHHxp4lkBzAKYwAghADOAd0HF0WRnmLCwxFBQDUrBngC+25I34AbBACNCRgHRDRE6aWo2xUmQx1p0nIA), keeping `getAnswer()` as a residual function in the output:

```js
(function () {
  var _0 = function () {
    return 2 + 2;
  };

  getAnswer = _0;
})();
```

Note that `getAnswer()` did **not** get optimized because it's a residual function, and isn't executed at initialization time. The `+` operation is still there. The only reason we see `2` and `2` instead of `x` and `y` is because they don't change throughout the program, so Prepack treats them as constants.

But what if we generated a function dynamically, and then attached it to a global? For example:

```js
(function() {
  function makeCar(color) {
    return {
      getColor() { return color; },
    }
  };
  global.cars = ['red', 'green', 'blue', 'yellow', 'pink'].map(makeCar);
})();
```

Here, we create several objects, and each of those objects contains a `getColor()` function that closes over a different value given to `makeCar()`. [The Prepack output looks like this:](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1vNeJNAWwEMBrAUwGFSAnYKBAGwTvW11zspjDoiYcXXAHNe1Fm1SY0PPgLRNWdANxoAvgBphuDcI2rho1gCNSzAHRR6AZzQBeNAG0A5DwAmrrWleielBDevqbMYJTBrgCelMysAO6RAA5wEOSuALqWZEnAZFS07EZAA)

```js
(function () {
  var _2 = function () {
    return "red";
  };

  var _5 = function () {
    return "green";
  };

  var _8 = function () {
    return "blue";
  };

  var _B = function () {
    return "yellow";
  };

  var _E = function () {
    return "pink";
  };

  cars = [{
    getColor: _2
  }, {
    getColor: _5
  }, {
    getColor: _8
  }, {
    getColor: _B
  }, {
    getColor: _E
  }];
})();
```

Note how in the output, Prepack didn't keep the `makeCar()` abstraction. Instead it executed the `makeCar()` calls, and serialized the *functions* they returned. This is why we have many `getColor()` functions in the output, one per a Car object.

This example also demonstrates that **Prepack optimizes the runtime performance, potentially at the cost of byte size.** It is faster for a JavaScript engine to execute the code generated by Prepack because it doesn't have to do the function calls and initialize all the nested closures. But in return, the generated code may be larger than the input code--sometimes, excessively so.

While this "code explosion" can help find areas of the code that do too much expensive metaprogramming at initialization time, this makes it harder to use Prepack in projects where the bundle size is sensitive (such as on the web). Today, the easiest way to get around a "code explosion" is to [delay running such code and move it into a residual function itself](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1vNeJNAWwEMBrAUwGFSAnYKBAGwTvW11zspjDoiYcXXAHNe1Fm1SY0PPgLRNWdANxoAvgBphuDcI2rh+WIkFkqtOgGcZnLqNYAjUswB0UetbQBeNAG0Ach4AE0CtNEDRHkoIcMinZjBKeMCAT0pmVgB3VIAHOAhyQIBdNzI84AsaehQjPWFHBBd3aqtvPzavIw0UVFUgA), thus moving it outside of Prepack execution path. Of course, in that case Prepack won't optimize it. Longer term, Prepack may offer better heuristics and control over the speed vs. size tradeoff.

### Lazy Closure Initialization

In the previous example, the `color` values were just inlined into the residual functions because they were constant. But what if the `color` value in the closure could change over time? Consider this example with a new `paint(newColor)` method:

```js
(function() {
  function makeCar(color) {
    return {
      getColor() { return color; }, // Reads color
      paint(newColor) { color = newColor; }, // Mutates color
    }
  };
  global.cars = ['red', 'green', 'blue'].map(makeCar);
})();
```

Now Prepack can't just emit a bunch of `getColor()` functions with statements like `return "red"` because the external code could change the color over time by calling `paint(newColor)`.

Here is the [generated code for this scenario](https://prepack.io/repl.html#BQMwrgdgxgLglgewsAlAAgN4Cg1vNeJNAWwEMBrAUwGFSAnYKBAGwTvW11zspjDoiYcXXAHNe1Fm1SY0PPgLRNWdANxoAvgBphIgA6k4EGMAiUA7pJUclUumgC8aM5bvrtuzcI2rho1gBGpMwAdFD0AM6OaADaAOQ8ACZxWmhxojyUEClpAcxglHEAuiFkesBkVLTsvhooqKpAA):

```js
(function () {
  var __scope_0 = Array(3);

  var __scope_1 = function (__selector) {
    var __captured;
    switch (__selector) {
      case 0:
        __captured = ["red"];
        break;
      case 1:
        __captured = ["green"];
        break;
      case 2:
        __captured = ["blue"];
        break;
      default:
        throw new Error("Unknown scope selector");
    }

    __scope_0[__selector] = __captured;
    return __captured;
  };

  var $_0 = function (__scope_2) {
    var __captured__scope_2 = __scope_0[__scope_2] || __scope_1(__scope_2);
    return __captured__scope_2[0];
  };

  var $_1 = function (__scope_2, newColor) {
    var __captured__scope_2 = __scope_0[__scope_2] || __scope_1(__scope_2);
    __captured__scope_2[0] = newColor;
  };

  var _2 = $_0.bind(null, 0);
  var _4 = $_1.bind(null, 0);
  var _6 = $_0.bind(null, 1);
  var _8 = $_1.bind(null, 1);
  var _A = $_0.bind(null, 2);
  var _C = $_1.bind(null, 2);

  cars = [{
    getColor: _2,
    paint: _4
  }, {
    getColor: _6,
    paint: _8
  }, {
    getColor: _A,
    paint: _C
  }];
})();
```

This looks complicated! Let's see what's going on here.

**Note: it's totally fine if you don't understand this section from the first attempt. I only understood what was happening after I started writing this section.**

It might be easier to start reading this from the bottom, and work our way upwards. First of all, we can see that Prepack still doesn't leave the `makeCar()` abstraction in place, and pieces objects together manually to avoid function calls and closure creation overhead. Each function instance is different:

```js
  cars = [{
    getColor: _2, // redCar.getColor
    paint: _4     // redCar.paint
  }, {
    getColor: _6, // greenCar.getColor
    paint: _8     // greenCar.paint
  }, {
    getColor: _A, // blueCar.getColor
    paint: _C     // blueCar.paint
  }];
```

Where do these functions come from? Prepack declares them above:

```js
  var _2 = $_0.bind(null, 0); // redCar.getColor
  var _4 = $_1.bind(null, 0); // redCar.paint

  var _6 = $_0.bind(null, 1); // greenCar.getColor
  var _8 = $_1.bind(null, 1); // greenCar.paint
  
  var _A = $_0.bind(null, 2); // blueCar.getColor
  var _C = $_1.bind(null, 2); // blueCar.paint
```

We can see that the function being bound (`$_0` and `$_1`) corresponds to the car method (`getColor` and `paint`, respectively). Prepack reuses the same implementations of them for all instances.

However, those functions need to know *which* of the three independent mutable colors each of them should read and write. Effectively, Prepack needs to emulate [JavaScript closures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures) without creating nested functions.

To solve this problem, the `bind()` argument (`0`, `1`, and `2`) provides a hint as to which of the colors is being "captured" by a function. In this example, color number `0` is initially `'red'`, color number `1` starts as `'green'`, and number `2` is `'blue'` at first. The current colors are kept in an array, and it is lazily initialized by this function:

```js
  var __scope_0 = Array(3); // index -> color mapping

  var __scope_1 = function (__selector) { // __selector is the index
    var __captured;
    switch (__selector) {
      case 0:
        __captured = ["red"];
        break;
      case 1:
        __captured = ["green"];
        break;
      case 2:
        __captured = ["blue"];
        break;
      default:
        throw new Error("Unknown scope selector");
    }

    __scope_0[__selector] = __captured; // store initial value in the array
    return __captured;
  };
```

In the code above, `__scope_0` is an array where Prepack keeps a mapping from the color index to the current color value. And `__scope_1` is a function that sets the initial color in the array at a given index.

Finally, all the `getColor()` implementation does is read the current color value from the color array. If that array doesn't exist yet, it lazily initializes it by calling the function we just described:

```js
  var $_0 = function (__scope_2) {
    var __captured__scope_2 = __scope_0[__scope_2] || __scope_1(__scope_2);

    return __captured__scope_2[0];
  };
```

Simliarly, the `paint()` implementation ensures the array exists, and then *writes* to it.

```js
  var $_1 = function (__scope_2, newColor) {
    var __captured__scope_2 = __scope_0[__scope_2] || __scope_1(__scope_2);

    __captured__scope_2[0] = newColor;
  };
```

Why do we have `[0]` in both places, and why do we write `["red"]` to the array instead of storing colors directly? Each closure may contain more than one mutable variable, so Prepack uses an additional level of array nesting to refer to them. In our example `color` was the only mutable variable in that closure, so Prepack used a single-element array to keep it.

You may be concerned that the generated code is pretty long. It gets better after minification. Currently, this part of the serializer is focused more on correctness rather than most efficient output.

Most likely, the output can be improved on a case-by-case basis so don't hesitate to file issues if you see opportunities for optimizations. In the beginning, Prepack didn't generate code that would allocate closures lazily. Instead, all captured variables were lifted to and initialized in the generated global code. Again, this is a speed / code size trade off that can and will be tuned over time.

### Environment Matters

At this point you might be tempted to try copy and pasting some of your existing initialization code into the Prepack REPL. However, you may soon discover that such basic features as `window` or `document` in the browser, or `require` from Node, don't work as you'd expect.

For example, the React DOM bundle contains this feature detection code that Prepack [can't compile](https://prepack.io/repl.html#G4QwTgBAJg9gxgVwLYFMB2AXAsjKKIC8EaCANqQNwBQAlgGYQAUA5LIqpjnsxDWtPGToMASggBvKhAHthXfETZDMAOiUdsuFNQC+VIA):

```js
var documentMode = null;
if ('documentMode' in document) {
  documentMode = document.documentMode;
}
```

The error message is:

```
PP0004 (2:23):  might be an object that behaves badly for the in operator
PP0001 (3:18):  This operation is not yet supported on document at documentMode
A fatal error occurred while prepacking.
```

Most Prepack error codes correspond to a Wiki page with a description of this error. For example, here is a page for [`PP0004`](https://github.com/facebook/prepack/wiki/PP0004). (The other `PP0001` error is from a legacy error system that [you can help migrate away from](https://github.com/facebook/prepack/issues/1898).)

So why didn't this code work? To answer this question we need to recall what makes Prepack work in the first place. **In order to execute code, Prepack usually needs to know what different values are equal to. But some things are only known at runtime.**

Prepack can't possibly know what browser the code will run in ahead of time, so it [can't be sure](https://github.com/facebook/prepack/wiki/PP0004) whether it's safe to apply the `in` operator to the `document` object, or if it's going to throw (and thus take a potentially different code path if there's a `try` / `catch` above).

This sounds pretty grim. After all, it is common for the initialization code to read something from the environment that is not known at the build time. There are two ways around this.

One way is to only Prepack the code that doesn't depend on external data, and put any environment checks outside of the Prepacked bundle. This can be a reasonable strategy if such code is easy to isolate.

Another way to solve this is to use Prepack's most powerful feature: **abstract values**.

We will look at abstract values  in detail in the next sections, but the gist is that in a limited set of cases, Prepack can execute code even if it doesn't know the exact values of some expressions, and you can give it some further hints for things like Node or browser APIs, or other unknown inputs.

## To Be Continued

We've covered the basics of how Prepack works, but we haven't looked at its most interesting capabilities yet:

* Manually optimizing selected residual functions.
* Running code even when some values are unknown.
* How Prepack "joins" the flow of function execution.
* Using Prepack to see all values a variable can take.
* Experimental React compilation mode.
* Checking out Prepack locally and debugging it.

We will explore those topics in the next articles.

