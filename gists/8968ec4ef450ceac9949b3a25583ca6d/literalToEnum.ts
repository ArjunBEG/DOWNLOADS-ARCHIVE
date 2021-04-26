type ValueOf<T> = T[keyof T];

export const literalToEnum = <Enum extends Record<string, string | number>>(
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  enumButJustForTyping: Enum
) => <Candidate extends EnumLiteralType<Enum>>(v: Candidate) =>
  (v as string) as LiteralToEnum<Enum, Candidate>;

export type LiteralToEnum<
  Enum extends Record<string, string | number>,
  Target extends string | number
> = PreserveUnmatched<
  ValueOf<{ [K in keyof Enum]: MatchEnum<Target, Enum[K]> }>,
  Target
>;
export type LiteralAsEnum<
  EnumValue extends string | number,
  Target extends string | number
> = PreserveUnmatched<
  EnumValue extends any ? MatchEnum<Target, EnumValue> : never,
  Target
>;
type MatchEnum<
  Candidate extends string | number,
  Target extends string | number
> = Candidate extends any
  ? { 0: never; 1: [Candidate, Target] }[Target extends Candidate ? 1 : 0]
  : never;
type PreserveUnmatched<T extends [any, any], U> = U extends T[0] ? T[1] : U;
type EnumLiteralType<E extends Record<string, string | number>> = ValueOf<
  { [K in keyof E]: WidenStringNumber<E[K]> }
>;
type WidenStringNumber<T> = T extends string
  ? string
  : T extends number
  ? number
  : never;
