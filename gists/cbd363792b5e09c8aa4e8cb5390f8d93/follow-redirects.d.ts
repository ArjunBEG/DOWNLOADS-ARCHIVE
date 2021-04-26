declare module 'follow-redirects' {
//

import * as coreHttp from 'http'
import * as coreHttps from 'https'

interface Scheme<Options, Callback, Request>  {
  request(options: Options, callback: Callback): Request
}

type WrappedScheme<T extends Scheme<any, any, any>> = T & {
  request(
    options: (T extends Scheme<infer Options, any, any> ? Options : {}) & FollowOptions,
    callback: T extends Scheme<any, infer Callback, any> ? Callback : never
  ): T extends Scheme<any, any, infer Response> ? Response : never
}

interface FollowOptions {
  maxRedirects?: number
  maxBodyLength?: number
}

export const http: WrappedScheme<typeof coreHttp>
export const https: WrappedScheme<typeof coreHttps>

export type HttpRequestOptions = coreHttp.RequestOptions & FollowOptions
export type HttpsRequestOptions = coreHttps.RequestOptions & FollowOptions

export function wrap<T extends {[key: string]: Scheme<any, any, any>}>(protocols: T): {
  [K in keyof T]: WrappedScheme<T[K]>
}

//
}
