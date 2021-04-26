I saw [this poll](https://twitter.com/wesleytodd/status/1303048777687855105) on Twitter earlier and was surprised at the result, which at the time of writing overwhelmingly favours option 1:

<img width="587" alt="Screen Shot 2020-09-10 at 10 19 22 AM" src="https://user-images.githubusercontent.com/1162160/92744135-34ade900-f34f-11ea-823e-112ba7902a67.png">

I've always been of the opinion that the `(req, res, next) => {}` API is the worst of all possible worlds, so one of two things is happening:

* I'm an idiot with bad opinions (very possibly!)
* People like familiarity


## Why I dislike option 1

It's bad for composition in two ways. Firstly, for all but the most trivial handlers, you have to awkwardly pass the `res` object around:

```js
app.use((req, res, next) => {
  if (some_condition_is_met(req)) {
    return render_view(req, res);
  }
  
  next();
})
```

Secondly, combining middleware often involves monkey-patching the `res` object:

```js
function log(req, res, next) {
  const { writeHead } = res;
  const start = Date.now();
  
  let details;
  
  res.writeHead = (status, message, headers) => {
    if (!headers && typeof message !== 'string') {
      headers = message;
      message = '';
    }
    
    details = { status, headers };
    
    writeHead.call(res, status, message, headers);
  };
  
  res.on('finish', () => {
    console.log(`${req.method} ${req.url} (${Date.now() - start}ms): ${details.status} ${JSON.stringify(details.headers)}`);
  });
  
  next();
}

app.use(log).use((req, res, next) => {...});
```

Monkey-patching objects belonging to the standard library is no more advisable here than it was in MooTools, but it's endemic in the ecosystem around Node servers.

In addition, because the built-in `res` object makes it difficult to do something as straightforward as responding with some JSON, and because `send(res, data)` is awkward, Express apps use a superclass of `http.ServerResponse` that adds a `res.send(data)` method among other things. I'm really not a fan of this pattern. Libraries shouldn't (but seemingly sometimes do) assume that these extra methods exist, making it harder to combine logic from different places.

## An alternative

Passing the `res` object around is reminiscent of a pattern that used to be extremely prevalent in Node apps:

```js
function do_something(foo, cb) {
  if (!is_valid(foo)) {
    return cb(new Error('Invalid foo!'));
  }
  
  do_something_with_validated_foo(foo, cb);
}

do_something({...}, (err, result) => {
  if (err) throw err;
  console.log(result);
});
```

Nowadays the ergonomomics around asynchronicity are much better thanks to `async`/`await`, which means we can use a more natural approach: the `return` keyword.

```js
function do_something(foo) {
  if (!is_valid(foo)) {
    throw new Error('Invalid foo!');
  }
  
  return do_something_with_valid_foo(foo);
}

console.log(await do_something({...}));
```

Conceptually, a response to an HTTP request is basically the same thing as a value returned from a function. So why don't we model it as such?

```js
app.use(req => {
  if (some_condition_is_met(req)) {
    return render_view(req);
  }
  
  // no returned object, implicit next()
});
```

Here, the returned value could be a `new Response(...)` where `Response` is some built-in object, or it could be something more straightforward:

```js
{
  status: 200,
  headers: {
    'Content-Type': 'text/html',
    'Content-Length': 21
  },
  body: '<h1>Hello world!</h1>'
}
```

(`body` could also be a `Buffer` or a `Stream` or a `Promise`, perhaps.)

This pattern lends itself to composition:

```js
const respond = (body, headers, status = 200) => ({
  body,
  status,
  headers: Object.assign({ 'Content-Length': body.length }, headers)
});

const json = obj => respond(JSON.stringify(obj), {
  'Content-Type': 'application/json'
});

app.use(() => json({
  answer: 42
}));
```

Middlewares can be composed the way [Koa](https://koajs.com/) does it:

```js
const wrap = stream => new Promise((fulfil, reject) => {
  stream.on('finish', () => fulfil());
  stream.on('error', reject);
});

async function log(req, next) {
  const start = Date.now();
  const res = await next();

  await res.body instanceof stream.Readable
    ? wrap(res.body)
    : res.body;
    
  console.log(`${req.method} ${req.url} (${Date.now() - start}ms): ${res.status} ${JSON.stringify(res.headers)}`);
  
  return response;
}

app.use(log).use((req, next) => ({...}));
```

---

It's likely that I've overlooked some crucial constraints. But if we're looking at evolving the built-in Node HTTP APIs, I hope we can take this rare opportunity to do so without being beholden to the way we do things now.