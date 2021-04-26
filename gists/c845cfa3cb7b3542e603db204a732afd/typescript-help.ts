// Trying to replicate this easy-as-pie Haskell type:
// fmap:: (a -> b) -> f a -> f b

// And failing miserably.

// OK, verbose, but I think we're on the right track...
// First, we define functor.
interface Functor<T> {
    map<U> (f: (x: T) => U): Functor<U>
}
// Now we have our fmap signature, right?
type fmap<T, U> = (f: (x: T) => U) => (mappable: Functor<T>) => Functor<U>

// But we can't use it? TypeScript is asking for the type arguments
// but we don't know them at this point.
// const map: fmap = f => mappable => mappable.map(f);

// Maybe we can build the signature inline?
const fmap = <T, U>(f: (x: T) => U): ((mappable: Functor<T>) => Functor<U>) =>
    mappable => mappable.map(f);

// But it can't infer x?
// This is a type error:
// const double = fmap(x => x * 2);
// This is not:
const double = fmap((x: number) => x * 2);

// Building our own functor seems easier than typing fmap:
type box = <T, U>(x: T) => Functor<U>
const box: box = (value: any) => ({
    map: f => box(f(value)),
    toString: () => `Box(${value})`
});

console.log(double([2, 4, 6]));
console.log(double(box(20)).toString());

// After all that work, the type is still wrong...
console.log(box([1, 2, 3]).map((x: number[]) => x.length));
/*
Argument of type '(x: number[]) => number' is not assignable to parameter of type '(x: unknown) => number'.
  Types of parameters 'x' and 'x' are incompatible.
    Type 'unknown' is not assignable to type 'number[]'.
*/