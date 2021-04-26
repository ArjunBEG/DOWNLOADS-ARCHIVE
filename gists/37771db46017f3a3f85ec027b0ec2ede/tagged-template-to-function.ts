type TemplateAtom<T = any> = () => never
                  
function t<T>(): TemplateAtom<T>
function t(strings: TemplateStringsArray): () => string
function t<A1>(strings: TemplateStringsArray, a1: TemplateAtom<A1>): (a1: A1) => string
function t<A1, A2>(strings: TemplateStringsArray, a1: TemplateAtom<A1>, a2: TemplateAtom<A2>): (a1: A1, a2: A2) => string
function t<A1, A2, A3>(strings: TemplateStringsArray,
  a1: TemplateAtom<A1>, a2: TemplateAtom<A2>, a3: TemplateAtom<A3>
): (a1: A1, a2: A2, a3: A3) => string
function t<A1, A2, A3, A4>(strings: TemplateStringsArray,
  a1: TemplateAtom<A1>, a2: TemplateAtom<A2>, a3: TemplateAtom<A3>, a4: TemplateAtom<A4>
): (a1: A1, a2: A2, a3: A3, a4: A4) => string
function t<A1, A2, A3, A4, A5>(strings: TemplateStringsArray,
  a1: TemplateAtom<A1>, a2: TemplateAtom<A2>, a3: TemplateAtom<A3>, a4: TemplateAtom<A4>, a5: TemplateAtom<A5>
): (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5) => string
function t<A1, A2, A3, A4, A5, A6>(strings: TemplateStringsArray,
  a1: TemplateAtom<A1>, a2: TemplateAtom<A2>, a3: TemplateAtom<A3>, a4: TemplateAtom<A4>, a5: TemplateAtom<A5>, a6: TemplateAtom<A6>
): (a1: A1, a2: A2, a3: A3, a4: A4, a5: A5, a6: A6) => string
function t<A>(strings: TemplateStringsArray, ...args: TemplateAtom<A>[]): (...args: A[]) => string
function t(strings?: TemplateStringsArray, ...values: TemplateAtom<any>[]): TemplateAtom<any> | ((...values: any[]) => string) {
  if (arguments.length <= 0 || strings === undefined) return t as TemplateAtom<any>

  return (...values) => {
    const output: string[] = []
    const l = strings.length
    for (let i = 0; i < l; i++) {
      output.push(strings[i])
      if (i < l) {
        output.push(String(values[i]))
      }
    }
    return output.join('')
  }
}
// usage
const a = t`ab${t<number>()}foo${t<string>()}`
