# Useful javascript util functions

## Table of contents

- [flatten object](#flatten-object)


### Flatten Object

```js
function flattenObject(obj) {
  var output = {};

  for (var i in obj) {
    var v = obj[i];
    if (Array.isArray(v)) {
      output[i] = v.map(o => flattenObject(o));
    }
    else if (typeof v === "object") {
      temp = flattenObject(v)

      for (var k in temp) {
        output[i + '_' + k] = temp[k];
      }
    }
    else {
      output[i] = v;
    }
  }

  return output;
}

flatten({a: 1, b: { c: '2', d: [1, 2, { x: '1' }], f: { g: 'gokul' } }});

Result: {
  "a": 1,
  "b_c": "2",
  "b_d": [
    {},
    {},
    {
      "x": "1"
    }
  ],
  "b_f_g": "gokul"
}
```