**React 101™**

All these examples do essentially the same thing.

```jsx
return (
  <MyComponent
    something={something}
    somethingElse={somethingElse}
  >
    Child text
  </MyComponent>
);
```

```jsx
const children = 'Child text';

return (
  <MyComponent
    something={something}
    somethingElse={somethingElse}
  >
    {children}
  </MyComponent>
);
```

```jsx
return (
  <MyComponent
    children='Child text'
    something={something}
    somethingElse={somethingElse}
  />
);
```

```jsx
const children = 'Child text';

const props = {
  children,
  something,
  somethingElse
};

return (
  <MyComponent
    {...props}
  />
);
```

```jsx
const children = ['Child text'];

const props = {
  something,
  somethingElse
};

return React.createElement(
  MyComponent,
  props,
  children
);
```