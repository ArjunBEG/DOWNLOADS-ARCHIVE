# What forces layout / reflow

All of the below properties or methods, when requested/called in JavaScript, will trigger the browser to synchronously calculate the style and layout*. This is also called reflow or [layout thrashing](http://www.kellegous.com/j/2013/01/26/layout-performance/), and is common performance bottleneck. 

### Element

##### Box metrics
* `elem.offsetLeft`, `elem.offsetTop`, `elem.offsetWidth`, `elem.offsetHeight`, `elem.offsetParent`
* `elem.clientLeft`, `elem.clientTop`, `elem.clientWidth`, `elem.clientHeight`
* `elem.getClientRects()`, `elem.getBoundingClientRect()`

##### Scroll stuff
* `elem.scrollBy()`, `elem.scrollTo()`
* `elem.scrollIntoView()`, `elem.scrollIntoViewIfNeeded()`  
* `elem.scrollWidth`, `elem.scrollHeight`
* `elem.scrollLeft`, `elem.scrollTop` also, setting them


##### Focus
* `elem.focus()`  can trigger a *double* forced layout ([source](https://cs.chromium.org/chromium/src/third_party/WebKit/Source/core/dom/Element.cpp?q=updateLayoutIgnorePendingStylesheets+-f:out+-f:test&sq=package:chromium&dr=C)&l=2923)

##### Also…
* `elem.computedRole`, `elem.computedName`  
* `elem.innerText` ([source](https://cs.chromium.org/chromium/src/third_party/WebKit/Source/core/dom/Element.cpp?q=updateLayoutIgnorePendingStylesheets+-f:out+-f:test&sq=package:chromium&dr=C)&l=3440))

### getComputedStyle 

`window.getComputedStyle()` will typically force style recalc 

`window.getComputedStyle()` will force layout, as well, if any of the following is true: 

1. The element is in a shadow tree
1. There are media queries (viewport-related ones). Specifically, one of the following: ([source](https://cs.chromium.org/chromium/src/third_party/WebKit/Source/core/css/MediaQueryExp.cpp?type=cs&q=f:MediaQueryExp.cpp+MediaQueryExp::IsViewportDependent&l=192))
  * `min-width`, `min-height`, `max-width`, `max-height`, `width`, `height`
  * `aspect-ratio`, `min-aspect-ratio`, `max-aspect-ratio`
  * `device-pixel-ratio`, `resolution`, `orientation` , `min-device-pixel-ratio`, `max-device-pixel-ratio`
1. The property requested is one of the following:  ([source](https://cs.chromium.org/chromium/src/third_party/WebKit/Source/core/css/CSSComputedStyleDeclaration.cpp?dr=C&q=f:CSSComputedStyleDeclaration.cpp+isLayoutDependent&sq=package:chromium))
  * `height`, `width`
  * `top`, `right`, `bottom`, `left`
  * `margin` [`-top`, `-right`, `-bottom`, `-left`, or *shorthand*] only if the margin is fixed.
  * `padding` [`-top`, `-right`, `-bottom`, `-left`, or *shorthand*] only if the padding is fixed.
  * `transform`, `transform-origin`, `perspective-origin`
  * `translate`, `rotate`, `scale`
  * `grid`, `grid-template`, `grid-template-columns`, `grid-template-rows`
  * `perspective-origin`
  * These items were previously in the list but appear to not be any longer (as of Feb 2018): `motion-path`, `motion-offset`, `motion-rotation`, `x`, `y`, `rx`, `ry`

### window

* `window.scrollX`, `window.scrollY`
* `window.innerHeight`, `window.innerWidth`
* `window.getMatchedCSSRules()` only forces style


### Forms

* `inputElem.focus()`
* `inputElem.select()`, `textareaElem.select()`

### Mouse events

* `mouseEvt.layerX`, `mouseEvt.layerY`, `mouseEvt.offsetX`, `mouseEvt.offsetY` ([source](https://cs.chromium.org/chromium/src/third_party/WebKit/Source/core/events/MouseEvent.cpp?type=cs&q=f:Mouse+f:cpp+::computeRelativePosition&sq=package:chromium&l=517))

### document

* `doc.scrollingElement` only forces style

### Range

* `range.getClientRects()`, `range.getBoundingClientRect()`

### SVG

* Quite a lot; haven't made an exhaustive list , but [Tony Gentilcore's 2011 Layout Triggering List](http://gent.ilcore.com/2011/03/how-not-to-trigger-layout-in-webkit.html) pointed to a few.


### contenteditable
  
* Lots & lots of stuff, …including copying an image to clipboard ([source](https://cs.chromium.org/search/?q=UpdateStyleAndLayoutIgnorePendingStylesheets+file:%5Esrc/third_party/WebKit/Source/core/editing/+package:%5Echromium$&type=cs))
  

## *Appendix

* Reflow only has a cost if the document has changed and invalidated the style or layout. Typically, this is because the DOM was changed (classes modified, nodes added/removed, even adding a psuedo-class like :focus).
* If layout is forced, style must be recalculated first. So forced layout triggers both operations. Their costs are very dependent on the content/situation, but typically both operations are similar in cost.
* What should you do about all this? Well, the `More on forced layout` section below covers everything in more detail, but the short version is: 
  1. `for` loops that force layout & change the DOM are the worst, avoid them. 
  1. Use DevTools Timeline to see where this happens. You may be surprised to see how often your app code and library code hits this.
  1. Batch your writes & reads to the DOM (via [FastDOM](https://github.com/wilsonpage/fastdom) or a virtual DOM implementation). Read your metrics at the begininng of the frame (very very start of `rAF`, scroll handler, etc), when the numbers are still identical to the last time layout was done. 

<center>
<img src="https://cloud.githubusercontent.com/assets/39191/10144107/9fae0b48-65d0-11e5-8e87-c9a8e999b064.png">
 <i>Timeline trace of The Guardian. Outbrain is forcing layout repeatedly, probably in a loop.</i>
</center>

##### Cross-browser 
* The above data was built by reading the Blink source, so it's true for Chrome, Opera, and most android browsers.
* [Tony Gentilcore's Layout Triggering List](http://gent.ilcore.com/2011/03/how-not-to-trigger-layout-in-webkit.html) was for 2011 WebKit and generally aligns with the above. 
* Modern WebKit's instances of forced layout are mostly consistent: [`updateLayoutIgnorePendingStylesheets` - GitHub search - WebKit/WebKit ](https://github.com/WebKit/webkit/search?q=updateLayoutIgnorePendingStylesheets&utf8=%E2%9C%93)
* Gecko's reflow appears to be requested via FrameNeedsReflow. Results: [`FrameNeedsReflow` - mozilla-central search](http://lxr.mozilla.org/mozilla-central/search?string=FrameNeedsReflow&find=&findi=%5C.c&filter=%5E%5B%5E%5C0%5D*%24&hitlimit=&tree=mozilla-central)
* No concrete data on Edge/IE, but it should fall roughly in line, as the return values for these properties are spec'd. What would differ is the amount of clever optimization.

##### Browsing the Chromium source:
* forced layout (and style recalc): [`UpdateStyleAndLayoutIgnorePendingStylesheets` - Chromium Code Search](https://cs.chromium.org/search/?q=UpdateStyleAndLayoutIgnorePendingStylesheets+-f:out+-f:test&type=cs)
* forced style recalc: [`UpdateStyleAndLayoutTreeIgnorePendingStylesheets` - Chromium Code Search](https://cs.chromium.org/search/?q=UpdateStyleAndLayoutTreeIgnorePendingStylesheets++-f:out+-f:test&type=cs)

#### CSS Triggers

[CSS Triggers](http://csstriggers.com/) is a related resource and all about what operations are required to happen in the browser lifecycle as a result of setting/changing a given CSS value. It's a great resource.  The above list, however, are all about what forces the purple/green/darkgreen circles synchronously from JavaScript. 

#### More on forced layout

* [Avoiding layout thrashing — Web Fundamentals](https://developers.google.com/web/fundamentals/performance/rendering/avoid-large-complex-layouts-and-layout-thrashing?hl=en)
* [Fixing Layout thrashing in the real world | Matt Andrews](https://mattandre.ws/2014/05/really-fixing-layout-thrashing/)
* [Timeline demo: Diagnosing forced synchronous layouts - Google Chrome](https://developer.chrome.com/devtools/docs/demos/too-much-layout)
* [Preventing &apos;layout thrashing&apos; | Wilson Page](http://wilsonpage.co.uk/preventing-layout-thrashing/)
* [wilsonpage/fastdom](https://github.com/wilsonpage/fastdom)
* [Rendering: repaint, reflow/relayout, restyle / Stoyan](http://www.phpied.com/rendering-repaint-reflowrelayout-restyle/)
* [We spent a week making Trello boards load extremely fast. Here’s how we did it. - Fog Creek Blog](http://blog.fogcreek.com/we-spent-a-week-making-trello-boards-load-extremely-fast-heres-how-we-did-it/)
* [Minimizing browser reflow  |  PageSpeed Insights  |  Google Developers](https://developers.google.com/speed/articles/reflow?hl=en)
* [Optimizing Web Content in UIWebViews and Websites on iOS](https://developer.apple.com/videos/wwdc/2012/?id=601)
* [Accelerated Rendering in Chrome](http://www.html5rocks.com/en/tutorials/speed/layers/)
* [web performance for the curious](https://www.igvita.com/slides/2012/web-performance-for-the-curious/)
* [Jank Free](http://jankfree.org/)

-------------

Updated slightly Feb 2018. Codesearch links and a few changes to relevant element properties.