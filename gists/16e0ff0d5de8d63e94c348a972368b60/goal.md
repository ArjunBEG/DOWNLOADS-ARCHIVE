Aim is to have two strings:

```
/** Available extra options  */
interface ExampleOptions {
    /** OK */
    noErrors: false;
    showEmit: false;
}
```

and

```
/**
 * Converts code into
 *
 * @param code The fourslash code
 * @param extension For example: ts, tsx, typescript, javascript, js
 */
export function twoslasher(code: string, extension: string);
```
