James Powell - james@nycpython.com

itertools
---------
- useful for dealing with iterators & iterables
- e.g. chain (for appending lists and tuples, instead of +)
- also includes algorithms, e.g. takewhile (e.g. takewhile fibonacci < 50)

generators
----------
- memory efficient when you need subset of entire return value
- generating an instance is expensive, so avoid generators unless the operation
  is also expensive. tl;dr sometimes generators are faster, but not always

```py
>>> def pairwise(xs):
...     xs = iter(xs)
...     x = next(xs)
...     for y in xs:
...             yield x, y
...             x = y
... 
>>> print list(pairwise(xrange(10)))
[(0, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 7), (7, 8), (8, 9)]
```

OR with a single line using itertools using tee, izip, islice (but more
difficult to understand).

- sometimes you have to decide if your algorithm returns first n numbers or
  returns value that go up to but not exceeding n
  - use generators instead! both are possible and decision left up to the user
  
```py
def fibonacci(a=1, b=1):
  while True:
    yield a
    a, b = b, a+b
```

decorator
---------
```py
>>> from contextlib import contextmanager
>>> @contextmanager
... def ctx():
...     print 'setup code'
...     yield
...     print 'teardown code'
... 
>>> with ctx():
...     print 'do stuff'
... 
setup code
do stuff
teardown code
```

Typical usage:

        @contextmanager
        def some_generator(<arguments>):
            <setup>
            try:
                yield <value>
            finally:
                <cleanup>
    
    This makes this:
    
        with some_generator(<arguments>) as <variable>:
            <body>
    
    equivalent to this:
    
        <setup>
        try:
            <variable> = <value>
            <body>
        finally:
            <cleanup>

This is an alternative to

```py
class controlled_execution():
  def __enter__(self):
    print 'setup and return thing'
  def __exit__(*args, **kwargs): # __....__ called context guards
    print 'teardown' # no matter what happens, __exit__ is called

with controlled_execution() as thing:
    print 'use thing'
    # auto-assigns return value of __enter__ to variable thing
```

This is what file object uses, allowing you to do

```py
with open(filename) as f:
    data = f.read()
    # do something with data
```

finally
-------
- don't write classes, write functions (with generators)
  - if that's not good enough, write a class
- write as little code as you can, each line is a liability
- python crash course at github.com/pycademy