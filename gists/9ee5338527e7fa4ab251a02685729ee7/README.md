From [this Twitter convo](https://twitter.com/Rich_Harris/status/933745598754447360). It would be cool to have a plugin that allowed you to use bare module specifiers (`import * as React from 'react'`) in your app, and converted them to unpkg.com URLs.

Say you have these two source files:

```js
// main.js
import * as React from 'react';
import * as ReactDOM from 'react-dom';
import message from './message.js';

class App extends React.Component {
  render() {
    return (
      <h1>{message}</h1>
    );
  }
}

ReactDOM.render(<App/>, document.body)
```

```js
// message.js
export default 'Hello world!';
```

Rollup (or webpack, if you're into that sort of thing) could generate this output, determining from the relevant package.json files that a) `react` and `react-dom` have the `module` field (note: they currently don't), and b) we're using a specific version of each:

```js
import * as React from 'https://unpkg.com/react@16.1.1/esm/index.js?module';
import * as ReactDOM from 'https://unpkg.com/react-dom@16.1.1/esm/index.js?module';

const message = 'Hello world!';

class App extends React.Component {
  render() {
    return (
      <h1>{message}</h1>
    );
  }
}

ReactDOM.render(<App/>, document.body)
```

Stick a `<script type='module' src='bundle.js'></script>` in your `index.html` and you're off to the races.