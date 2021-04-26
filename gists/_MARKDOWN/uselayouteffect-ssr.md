If you use server rendering, keep in mind that neither `useLayoutEffect` nor `useEffect` can run until the JavaScript is downloaded.

You might see a warning if you try to `useLayoutEffect` on the server. Here's two common ways to fix it.

## Option 1: Convert to useEffect

If this effect isn't important for first render (i.e. **if the UI still looks valid before it runs**), then `useEffect` instead.

```js
function MyComponent() {
  useEffect(() => {
    // ...
  });
}
```

Like `useLayoutEffect`, it won't run on the server, but it also won't warn.

## Option 2: Lazily show component with useLayoutEffect

If UI looks broken with `useEffect` but gets fixed by `useLayoutEffect`, it means that this component doesn't look right until the effect runs. However, that means **the server-rendered HTML version of it won't look right until JavaScript loads anyway**. So server-rendering it brings no benefit and shows a confusing UI.

To fix this, you can **delay showing that component** until after the client side JS loads and hydrates the component. To exclude a `Child` that needs layout effects from the server-rendered HTML, you can render it conditionally:

```js
function Parent() {
  const [showChild, setShowChild] = useState(false);
  
  // Wait until after client-side hydration to show
  useEffect(() => {
    setShowChild(true);
  }, []);
  
  if (!showChild) {
    // You can show some kind of placeholder UI here
    return null;
  }

  return <Child {...props} />;
}

function Child(props) {
  useLayoutEffect(() => {
    // This is where your layout effect logic can be
  });
}
```

For example, this is handy for jQuery plugins which can be initialized later.

---

If you have some use case that isn't covered, please [report a complete minimal code example here](https://github.com/facebook/react/issues/14927) and we'll try to help.