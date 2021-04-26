import {UnionToIntersection} from 'ts-essentials';
/**
 * Turns a union like `{ a: number } | { b: string }` into `{ a: number, b?:
 * never } | { b: string, a?: never }
 */
type UnionKeys<T> = T extends never ? never : keyof T;
export type UnionExpand<T> = ValueOf<UnionExpandInner<T, UnionKeys<T>>>;
type UnionExpandInner<T, Keys extends PropertyKey> = {
  [K in Keys]: T extends { [_ in K]: any }
    ? T & { [_ in Exclude<Keys, keyof T>]?: never }
    : never;
};

/**
 * Converts a union type (`A | B`) into a single type appropriate for an interface.
 *
 * @example
 * interface A {
 *   type: 'A';
 *   a: string;
 * }
 * interface B {
 *   type: 'B';
 *   b: number;
 * }
 *
 * type C = A | B;
 * // $ExpectType never
 * type Intersection = UnionToIntersection<C>;
 * // $ExpectType { type: 'A' | 'B' } & { a?: string, b?: number }
 * type Interface = UnionToInterface<C>;
 */
// prettier-ignore
export type UnionToInterface<T> = [
  Extract<T, null | undefined>,
  UnionToInterfacePrimitives<NonNullable<T>>
][T extends null | undefined ? 0 : 1];

type UnionToInterfacePrimitives<T> = [Extract<T, Primitive>] extends [never]
  ? UnionToInterfaceObject<T>
  : Extract<T, Primitive> & UnionToInterfaceObject<Exclude<T, Primitive>>;

// prettier-ignore
export type UnionToInterfaceObject<T> = UnionToInterfaceInner<T, 
  UnionToIntersection<RecordAny<T>>,
  UnionExpand<T>
>;
type RecordAny<T> = { [K in keyof T]: any };
type UnionToInterfaceInner<T, I, E> = {
  [K in Extract<keyof T, keyof I>]: E[Extract<K, keyof E>];
} & {
  [K in keyof I]?: E[Extract<K, keyof E>];
};

// And specifically, only with known keys
  
// From https://stackoverflow.com/questions/51465182/typescript-remove-index-signature-using-mapped-types
export type KnownKeys<T> = {
  [K in keyof T]: string extends K ? never : number extends K ? never : K;
} extends { [_K in keyof T]: infer U } ? U : never;
  
// prettier-ignore
export type IntersectingKnownKeys<T> = Extract<
  (T extends any ? (k: KnownKeys<T>) => void : never) extends
    (k: infer I) => void ? I : never,
  KnownKeys<T>
>;
  
export type AllKnownKeys<T> = T extends any ? KnownKeys<T> : never;
  
export type AllKnownFor<T> = {
  [K in IntersectingKnownKeys<T>]: T[K];
} & {
  [K in Exclude<AllKnownKeys<T>, IntersectingKnownKeys<T>>]: GetKnown<T, K>;
};

export type GetKnown<T, K extends keyof any> = T extends any
  ? K extends KnownKeys<T>
    ? T[K]
    : never
  : never;