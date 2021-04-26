import type { UnionToIntersection } from 'ts-essentials';

export type UnionToBuildable<T> = {
  -readonly [K in Extract<keyof UnionToIntersection<T>, keyof T>]: T[K];
} &
  {
    -readonly [K in Exclude<
      keyof UnionToIntersection<T>,
      keyof T
    >]?: T extends { [_ in K]: infer U } ? U : never;
  };
