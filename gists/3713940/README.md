**Code**

```javascript
/*not! @jsdoc*/

/**
 * Title
 *@pewpew1 ololo
 *
 *   @pewpew2 ololo
 * @pewpew3
 *  ololo
 *
 *  ololo
 */
function a() {

}

/**
 *@pewpew1 ololo
 *
 *   @pewpew1 ololo
 * @pewpew3
 *  ololo
 *
 *  ololo
 */
```

**Parse result**

```javascript
[{
    "pewpew1": ["ololo"],
    "pewpew2": ["ololo"],
    "pewpew3": ["ololo  ololo"]
}, {
    "pewpew1": ["ololo", "ololo"],
    "pewpew3": ["ololo  ololo"]
}]
```

Example http://jsfiddle.net/TQtdR/1/

**Known bugs**

  * matches emails