export function getMethodNames(
  apiObject: object = {}
): string[] {
  // Assume class instance.
  let list = Object.getOwnPropertyNames(
    Object.getPrototypeOf(apiObject)
  );

  // Detect plain object.
  if (list.includes('__proto__')) {
    list = Object.keys(apiObject);
  }

  list = list.filter(
    s => s !== 'constructor'
  );

  list = list.sort();

  // Expose array.
  return list;
}