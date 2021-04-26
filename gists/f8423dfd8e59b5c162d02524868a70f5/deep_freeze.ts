export function deepFreeze (
  obj: any
): any {
  const props = Object.getOwnPropertyNames(obj);

  props.forEach(prop => {
    const value = obj[prop];

    if (
      value !== null &&
      typeof value === 'object'
    ) {
      deepFreeze(value);
    }
  });

  return Object.freeze(obj);
};