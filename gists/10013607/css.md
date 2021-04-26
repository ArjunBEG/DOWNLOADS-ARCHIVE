#### Vertical centering

```css
position: absolute;
top: 50%;
transform: translateY(-50%);
```

Translate is processed at the end, meaning it is based on the final element height. This means it works with any element, even dynamic heights. Of course it only works on relatively new browsers, but translate is well accepted and on the path to being ubiquitous. The style is also easy to understand and isn't hacky.

#### Horizontal centering

```css
.center-div
{
     margin: 0 auto;
     width: 100px; 
}
```

The value `auto` in the `margin` property sets the left and right margins to the available space within the page. The thing to remember is your centered div must have a width property. Works on pretty much every browser.

Can also be used to center a div within another div. Or you can use

```html
<div class="outer-div">
  <div class="inner-div"></div>
</div>
```

```css
.outer-div
{
     padding: 30px;
     text-align: center;
}
.inner-div
{
     display: inline-block;
     padding: 50px;
}
```

The `text-align` property only works on inline elements. The `inline-block` value displays the inner div as an inline element as well as a block, so the `text-align` property in the outer div centers the inner div.

####  Vertical and horizontal centering of a div within another div

```css
.outer-div
{
     padding: 30px;
}
.inner-div
{
     margin: auto;
     width: 100px;
     height: 100px;  
}
```

The inner div must have a `width` and `height` property. This doesn't work if the outer div has a fixed height. Works with all modern browsers.

#### Centering a div at the bottom of a page

```css
.outer-div
{
     position: absolute;
     bottom: 70px;
     width: 100%;
}
.inner-div
{
     margin: 0 auto;
     width: 100px;
     height: 100px;
     background-color: #ccc;
}
```

The inner div must have a `width` property. The gap from the very bottom of the page is set in the outer div's bottom property. Works with all modern browsers.

#### Horizontal and vertical centering

```css
.center-div
{
     position: absolute;
     margin: auto;
     top: 0;
     right: 0;
     bottom: 0;
     left: 0;
     width: 100px;
     height: 100px;
     background-color: #ccc;
}
```

The div must have a `width` and `height` property. Works with all modern browsers.