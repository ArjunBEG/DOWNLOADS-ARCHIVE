
declare module 'axios/lib/adapters/http' {
//

import {RequestOptions, IncomingMessage, ClientRequest} from 'http'
import {AxiosRequestConfig, AxiosAdapter, AxiosPromise, AxiosProxyConfig} from 'axios'


function httpAdapter(config: httpAdapter.Config): AxiosPromise<any>

namespace httpAdapter {
  interface ProxyConfig extends AxiosProxyConfig {
    protocol?: string
  }
  interface Config extends AxiosRequestConfig {
    transport?: Transport
    proxy?: ProxyConfig
  }
  interface Transport {
    request(options: RequestOptions, callback: (res: IncomingMessage) => void): ClientRequest
  }

}

export = httpAdapter

//
}

declare module 'axios/lib/core/InterceptorManager' {
//

import {AxiosInterceptorManager} from 'axios'

interface Interceptor<V> {
  fulfilled?: (value: V) => V | Promise<V>
  rejected?: (error: any) => any
}

interface InterceptorManagerInternal<V> extends AxiosInterceptorManager<V> {
  forEach(fn: (interceptor: Interceptor<V>) => void): void
}

interface InterceptorManager {
  new<V>(): InterceptorManagerInternal<V>
}

const InterceptorManager: InterceptorManager

export = InterceptorManager

//
}
