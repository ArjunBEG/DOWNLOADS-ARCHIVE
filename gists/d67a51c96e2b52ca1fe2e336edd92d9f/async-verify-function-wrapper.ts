import {DoneVerifyFunc} from 'passport-azure-ad'

function safe<TUser, A1>(
  handler: (a1: A1) => PromiseLike<TUser>
): (a1: A1, done: DoneVerifyFunc<TUser>) => void
function safe<TUser, A1, A2>(
  handler: (a1: A1, a2: A2) => PromiseLike<TUser>
): (a1: A1, a2: A2, done: DoneVerifyFunc<TUser>) => void
function safe<TUser, A1, A2, A3>(
  handler: (a1: A1, a2: A2, a3: A3) => PromiseLike<TUser>
): (a1: A1, a2: A2, a3: A3, done: DoneVerifyFunc<TUser>) => void
function safe<TUser, A1, A2, A3, A4>(
  handler: (a1: A1, a2: A2, a3: A3, a4: A4) => PromiseLike<TUser>
): (a1: A1, a2: A2, a3: A3, a4: A4, done: DoneVerifyFunc<TUser>) => void
function safe<TUser, A1, A2, A3, A4, A5>(
  handler: (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5) => PromiseLike<TUser>
): (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, done: DoneVerifyFunc<TUser>) => void
function safe<TUser, A1, A2, A3, A4, A5, A6>(
  handler: (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6) => PromiseLike<TUser>
): (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6, done: DoneVerifyFunc<TUser>) => void
function safe<TUser, A1, A2, A3, A4, A5, A6, A7>(
  handler: (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6, a7: A7) => PromiseLike<TUser>
): (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6, a7: A7, done: DoneVerifyFunc<TUser>) => void
function safe<TUser, A1, A2, A3, A4, A5, A6, A7, A8>(
  handler: (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6, a7: A7, a8: A8) => PromiseLike<TUser>
): (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6, a7: A7, a8: A8, done: DoneVerifyFunc<TUser>) => void
function safe<TUser>(handler: (...args) => PromiseLike<TUser>): (...args: any[]) => void {
  const fn = (...args) => {
    const done: DoneVerifyFunc<TUser> = args.pop();
    handler(...args).then(
      (user: TUser) => done(null, user),
      (err: Error) => done(err)
    )
  }
  Object.defineProperty(fn, 'name', {value: handler.name})
  Object.defineProperty(fn, 'length', {value: handler.length + 1})

  return fn
}
