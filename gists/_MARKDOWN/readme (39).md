## console.log wrap resolving for your wrapped console logs

I've heard this before:

> What I really get frustrated by is that I cannot wrap `console.*` and preserve line numbers

We enabled this in Chrome DevTools via [blackboxing](https://developer.chrome.com/devtools/docs/blackboxing) a [bit ago](https://code.google.com/p/chromium/issues/detail?id=267592#c36).  

If you blackbox the script file the contains the console log wrapper, the script location shown in the console will be corrected to the original source file and line number. Click, and the full source is looking longingly into your eyes.


You can try it out here: http://plnkr.co/edit/3wg4u9HUGXfFH0U7MR7j

### Blackbox the source file:
![image](https://cloud.githubusercontent.com/assets/39191/6423072/5ff2ead8-be95-11e4-87ba-0e5902d1bb0e.png)

You can right-click the file in the editor, as well. Or blackbox via regex in Settings.

### Logs will be resolved back to their call frame.
![image](https://cloud.githubusercontent.com/assets/39191/6423146/9d9426c6-be96-11e4-8fa3-be98171b5d26.png)


FWIW, Blackboxing does a lot. Blackboxing a file means:

* Exceptions thrown from library code will not pause (if Pause on exceptions is enabled),
* Stepping into/out/over bypasses the library code,
* Event listener breakpoints don't break in library code,
* The debugger will not pause on any breakpoints set in library code.

Read more about it over at https://developer.chrome.com/devtools/docs/blackboxing

Cheers and thanks [crbug/249575](https://code.google.com/p/chromium/issues/detail?id=249575#c16)