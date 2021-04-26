const targetDebuggerNs = 'my-debug-namespace';

jest.mock('debug', () => {
	// tslint:disable-next-line: no-shadowed-variable
	const D = jest.requireActual('debug') as typeof import('debug');
	const mocks: jest.Mock[] = [];
	const m = jest.fn((ns) => {
		if (ns !== targetDebuggerNs) {
			return D(ns);
		}
		const debugInner = D(ns);
		const debugFn = Object.assign(jest.fn(debugInner), debugInner);
		mocks.push(debugFn);
		return debugFn.mockName(`debug('${ns}')`);
	});
	return Object.assign(m, D, {
		default: m,
		debug: m,
		mocks,
	});
});

const getDebugFn = (ns: string = targetDebuggerNs) => {
	const debugFn = ((D as any).mocks as IDebugger[]).find(
		(d) => d.namespace === ns
	);
	expect(debugFn).toHaveProperty('mock');
	return debugFn;
};

import D, { IDebugger } from 'debug';

// Test implementation goes here.

// usage is like `expect(getDebugFn()).not.toHaveBeenCalled()`