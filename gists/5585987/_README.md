# Parent/Child Y.Views #

As I worked with `Y.App` it became clear that while `Y.View` is a great abstraction it would be easy to overwhelm a single instance with way too much functionality. This is my attempt to solve that issue by allowing multiple child views to be attached to a single parent view via an extension.

## Usage ##

The extension is mixed into the parent view like any other extension using `Y.Base.create`.

```javascript
var Parent = Y.Base.create("view", Y.View, [
    Extensions.ViewParent
], {
    ...
});
```
    
The extension uses the `children` attribute, so when instantiating or initializing the parent you'll want to add the child views.

```javascript
var Parent = Y.Base.create(..., {
    ...,
    initializer : function(config) {
        this.set("children", {
            carousel : new Y.View({ ... }),
            featured : new Y.View({ ... }),
            sidebar  : new Y.View({ ... }),
            hot      : new Y.View({ ... })
        });
    }
});
```

`Parent` will require a `render` method since `Y.View` only provides a no-op stub by default.

```javascript
var Parent = Y.Base.create(..., {
    ...,
    
    render : function() {
        this.get("container").setContent(this.template());
        
        return this;
    }
});
```

In this example the `Parent` handles setting its child views automatically, so we just need to instantiate it.

```javascript
var parent = new Parent({ container : ".bd" }).render();
```

The extension will automatically render the child views into `parent.container` using the HTML5 data attributes `child` to determine where they should render themselves. Each child view's name in the `views` object should map to a DOM element with the same `data-child` attribute.

```html
<div class="bd yui3-g">
    <div class="main yui3-u">
        <!-- "carousel" child will render into this div -->
        <div class="carousel" data-child="carousel"></div>
        
        <div class="yui3-g lists">
            <!-- "featured" child will render into this div -->
            <div class="yui3-u-1-2" data-child="featured"></div>
            
            <!-- "hot" child will render into this div -->
            <div class="yui3-u-1-2" data-child="hot"></div>
        </div>
    </div>
    
    <!-- "sidebar" child will render into this div -->
    <div class="sidebar yui3-u" data-child="sidebar"></div>
</div>
```

Child views are regular views, they don't need to do anything special to work with a parent. The only thing the extension does is ensure that events from the child view will bubble to the parent. Unfortunately, to do this it has to add a `_viewparentchild` property onto each child instance. It also adds a `parent` attribute to every child view with a reference to the parent `Y.View` instance.

You could potentially also nest parents to achieve a multi-level heirarchy of views but that definitely hasn't been tested & things might go crazy.

## License ##

```
Copyright (c) 2013 Patrick Cavit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```