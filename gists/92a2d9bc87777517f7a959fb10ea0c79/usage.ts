print`foo: ${foo}`

print(null, (v) => {
  console.warn('converting to string', v)
  return String(v)
})`foo: ${foo}`

print(console.warn)`foo: ${foo}`

print(debug, {colors: false, depth: null})`Logging foo: ${foo}`