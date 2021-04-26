export const isTypeByProp = <T>(k: NonNullableProp<T>) => (
	obj: Partial<T>
// tslint:disable-next-line: triple-equals
): obj is T => obj[k as keyof T] != null;

type NonNullableProp<T> = {
	[K in KeyOf<T>]: T extends Record<K, any> ? K : never;
}[KeyOf<T>];
type KeyOf<T> = Extract<IfUnknown<KnownKeys<T>, keyof T>, keyof any>;
type IfUnknown<T, U> = unknown extends T ? T : U;
// https://stackoverflow.com/a/51956054/490829
type KnownKeys<T> = {
	[K in keyof T]: string extends K ? never : number extends K ? never : K;
} extends { [_ in keyof T]: infer U }
	? U
	: never;

