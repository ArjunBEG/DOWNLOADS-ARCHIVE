# 10x Developer Code

I came across some code awhile ago that, though I can't share exactly, I wanted to document as a "[foot gun](http://onlineslangdictionary.com/meaning-definition-of/foot-gun)."

You should never have a `class` that can be used both as a parent with helper methods _and_ can be instantiated.

Even if you did, there should never be `static` and public methods — by the same name — that do _**different**_ things.

```js
/*
  This is a pseudo coded version of
  a bad JavaScript `class` I noticed.

  I thought it'd be funny to document.
*/

class Robot {
  // Available directly.
  static helpHumans() {
    console.log('I help humans!');
  }

  // Available via `new`.
  helpHumans() {
    console.log('I kill humans!');
  }
}

const myRobot1 = Robot;
const myRobot2 = new Robot();

// Logs: "I help humans!"
console.log(
  myRobot1.helpHumans()
);

// Logs: "I kill humans!"
console.log(
  myRobot2.helpHumans()
);
```