// my brain decided to ask the question: yknow, i want you to think about the y combinator --
// like, what is it. like what the fuck girl, cmon, you have a comp sci degree, you should know this, and understand it and shit

// and so i was like fiiiiiiiiiiiiiiine gosh, lets see if typescript can handle the typing, and play around with it

// so i looked up a javascript implementation, and played with the type defintion until it
// matched up and then i was like oh: thats what the type definition of the functions in it are.
// i get it now. that's pretty cool. the main interesting thing is a the inner function that takes itself
// and returns the function initially passed to the outer function. neato.

// yay!
                              
type M<A extends any[], R> = (f: M<A, R>) => (...a: A) => R
//                               ^           ^
//                               |           and returns a function with the same
//                               |           signature as the inner function of `Y`
//                               this function takes itself

const Y = <A extends any[], R>(
  f: (g: (...a: A) => R) => (...a: A) => R
): ((...a: A) => R) =>
  ((m: M<A, R>) =>
    f((...x) => m(m)(...x))
  )((m: M<A, R>) =>
    f((...x) => m(m)(...x))
  )

// m stands for magic

// also, ya gotta give typescript the signature of your inner function in the outer function.
// it's doing great, but it's not that great yet
const fib = Y((f: (a: number) => number) => (n) => n > 1 ? n + f(n - 1) : 1)

// and with some further experimentation, using the example code of the abstractions, that were part
// of the y combinator example i was working from, i removed types that typescript could infer and determined the types
// for the abstractions too
type F<A extends any[], R> = (...a: A) => R

// redefinition of M, using F is more concise though
type M2<A extends any[], R> = (f: M<A, R>) => F<A, R>

type YF<A extends any[], R> = (g: F<A, R>) => F<A, R>
type Y = <A extends any[], R>(f: YF<A, R>) => F<A, R>

const Y1: Y = <A extends any[], R>(f: YF<A, R>) => (
  (m: M<A, R>) => f((...x) => m(m)(...x))
)(
  (m) => f((...x) => m(m)(...x))
)

// Using β-abstraction to eliminate code repetition.
const Y2: Y = <A extends any[], R>(f: YF<A, R>) => (
  (m: M<A, R>) => m(m)
)(
  (m) => f((...x) => m(m)(...x))
)

const Y3: Y = (<A extends any[], R>(m: M<A, R>) =>
  (f: YF<A, R>) => m(
    (n) => f((...x) => n(n)(...x))
  )
)((m) => m(m))

// some stuff from https://en.wikipedia.org/wiki/Recursion_(computer_science)#Recursive_programs
const fac = Y1((f: (a: number) => number) => (n) => n > 1 ? n * f(n - 1) : 1)
const gcd = Y2((f: (x: number, y: number) => number) =>
  (x, y) => y === 0 ? x : f(y, x % y)
)
const hanoi = Y3((f: (n: number) => number) =>
  (n) => n <= 1 ? 1 : 2 * f(n - 1) + 1
)

// and here's some code to run it in typescript playground
const append = (text: string) => {
    const p = document.createElement('p')
    p.innerText = text
    document.body.appendChild(p)
}
append(`fib(4) = ${fib(4)}`)
append(`fac(4) = ${fac(4)}`)
append(`gcd(111, 259) = ${gcd(111, 259)}`)
append(`hanoi(4) = ${hanoi(4)}`)