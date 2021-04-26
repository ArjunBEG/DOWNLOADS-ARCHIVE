export type Deintersect<T> = Compute<
	OptionalizeUndefined<
		{
			[K in keyof UnionToIntersection<T>]: T extends { [_ in K]: any }
				? T[K]
				: undefined;
		}
	>
>;
type Compute<A> = {
	[K in keyof A]: A[K];
} & {};
type OptionalizeUndefined<T> = {
	[K in UndefKeys<T>]?: NonUndef<T[K]>;
} &
	{ [K in Exclude<keyof T, UndefKeys<T>>]: T[K] };
type NonUndef<T> = T extends undefined ? never : T;
type UndefKeys<T> = Exclude<
	{
		[K in keyof T]: T extends Record<K, NonUndef<T[K]>> ? never : K;
	}[keyof T],
	undefined
>;
type UnionToIntersection<U> = (U extends any ? (k: U) => void : never) extends ((k: infer I) => void) ? I : never;
