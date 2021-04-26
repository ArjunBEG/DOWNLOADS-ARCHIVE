
interface CustomPromisify<F> {
  (...args): any
  __promisify__: F
}

type PromiseAsBluebird<P> = P extends PromiseLike<infer T> ? B<T> : B<P>

type ChangeReturnTypeFromPromiseToBluebird6<F> = F extends
  ((a1: infer A1, a2: infer A2, a3: infer A3, a4: infer A4, a5: infer A5, a6: infer A6) => PromiseLike<infer R>) ?
  ((a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6) => B<R>) : F
type ChangeReturnTypeFromPromiseToBluebird5<F> = F extends
  ((a1: infer A1, a2: infer A2, a3: infer A3, a4: infer A4, a5: infer A5) => PromiseLike<infer R>) ?
  ((a1: A1, a2: A2, a3: A3, a4: A4, a5: A5) => B<R>) : ChangeReturnTypeFromPromiseToBluebird6<F>
type ChangeReturnTypeFromPromiseToBluebird4<F> = F extends
  ((a1: infer A1, a2: infer A2, a3: infer A3, a4: infer A4) => PromiseLike<infer R>) ?
  ((a1: A1, a2: A2, a3: A3, a4: A4) => B<R>) : ChangeReturnTypeFromPromiseToBluebird5<F>
type ChangeReturnTypeFromPromiseToBluebird3<F> = F extends
  ((a1: infer A1, a2: infer A2, a3: infer A3) => PromiseLike<infer R>) ?
  ((a1: A1, a2: A2, a3: A3) => B<R>) : ChangeReturnTypeFromPromiseToBluebird4<F>
type ChangeReturnTypeFromPromiseToBluebird2<F> = F extends
  ((a1: infer A1, a2: infer A2) => PromiseLike<infer R>) ?
  ((a1: A1, a2: A2) => B<R>) : ChangeReturnTypeFromPromiseToBluebird3<F>
type ChangeReturnTypeFromPromiseToBluebird1<F> = F extends
  ((a1: infer A1) => PromiseLike<infer R>) ?
  ((a1: A1) => B<R>) : ChangeReturnTypeFromPromiseToBluebird2<F>
type ChangeReturnTypeFromPromiseToBluebird<F> = F extends
  (() => PromiseLike<infer R>) ?
  (() => B<R>) : ChangeReturnTypeFromPromiseToBluebird2<F>

function promisify<F>(func: CustomPromisify<F>) {
  return B.promisify(func) as any as F
}
function promisifyB<F>(func: CustomPromisify<F>) {
  return B.promisify(func) as ChangeReturnTypeFromPromiseToBluebird<F>
}