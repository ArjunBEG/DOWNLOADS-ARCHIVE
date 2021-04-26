export type WriteFn = (s: string) => void
export type TemplatePrintFn = (s: TemplateStringsArray, ...values: any[]) => void
export function print(write: WriteFn | null, mapOrOptions: ((value: any) => string) | util.InspectOptions): TemplatePrintFn
export function print(s: TemplateStringsArray, ...values: any[]): void
export function print(s: TemplateStringsArray | WriteFn | null, ...values: any[]): TemplatePrintFn | void {
  if (!(typeof s === 'function' || s === null)) {
    console.log(_print(inspect, s, values))
    return
  }

  const write = s || console.log.bind(console)

  const mapOrOptions: ((value: any) => string) | util.InspectOptions = values.shift()
  let map = inspect
  if (typeof mapOrOptions === 'function') {
    map = mapOrOptions
  } else if (mapOrOptions !== null) {
    map = (v) => util.inspect(v, mapOrOptions)
  }

  return (s: TemplateStringsArray, ...values: any[]) => write(_print(map, s, values))
}
function inspect(v) {
  return util.inspect(v, {colors: true, depth: 8, maxArrayLength: 20})
}
export function _print(map: (value: any) => string, s: TemplateStringsArray, values: any[]) {
  return s.reduce((s, t, i) => s + map(values[i - 1]) + t)
}
