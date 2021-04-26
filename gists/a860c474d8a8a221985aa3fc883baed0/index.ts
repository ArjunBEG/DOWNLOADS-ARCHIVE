export function fails<T extends [foo: any, bar?: any]>(a: T): T {
  return a;
}