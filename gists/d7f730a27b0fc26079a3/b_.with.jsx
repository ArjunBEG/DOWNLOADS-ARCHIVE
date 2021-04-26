var B = require('b_');

var Array_of = function (any) {
  return Array.prototype.slice.call(any);
};

B.with = function () {
  var b = this,
      curriedArgs = Array_of(arguments);
  
  return function () {
    return b.apply(null, curriedArgs.concat(Array_of(arguments)));
  };
};

var b = B.with('b-button');
var e = B.with('b-button', 'elem');

// After
function render() {
  return (
    <div className={b()}>
      <span className={b('icon', {type: 'add'})}></span>
      <span className={b('text')}></span>
    </div>
    <div className={b({size: 'small'})}>
      <span className={b('icon', {type: 'add'})}></span>
      <span className={b('text')}></span>
    </div>
  );
}

// Before
function render() {
  return (
    <div className={b('b-button')}>
      <span className={b('b-button', 'icon', {type: 'add'})}></span>
      <span className={b('b-button', 'text')}></span>
    </div>
    <div className={b('b-button', {size: 'small'})}>
      <span className={b('b-button', 'icon', {type: 'add'})}></span>
      <span className={b('b-button', 'text')}></span>
    </div>
  );
}
