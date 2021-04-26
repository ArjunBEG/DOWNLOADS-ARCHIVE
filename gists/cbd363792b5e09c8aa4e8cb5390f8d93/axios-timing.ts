
import http = require('http')
import https = require('https')
import url = require('url')
import {AxiosInstance, AxiosInterceptorManager} from 'axios'
import {HttpRequestOptions as HttpFollowRequestOptions, http as httpFollow, https as httpsFollow} from 'follow-redirects'
import now = require('performance-now')

import httpAdapter = require('axios/lib/adapters/http')
import InterceptorManager = require('axios/lib/core/InterceptorManager')

export interface TimingData {
  timingStart: number
  timings: {
    socket?: number
    lookup?: number
    connect?: number
    response?: number
    end?: number
  }
}

interface MaybeRedirectableRequest extends http.ClientRequest {
  _currentRequest?: http.ClientRequest
}

export function addAxiosTiming(axios: AxiosInstance) {
  const axiosExt = setupAxiosHttpInterceptors(axios)

  const pending: {req: MaybeRedirectableRequest, timingData: TimingData}[] = []

  axiosExt.interceptors.httpRequest.use((req) => {
    const timingStart = now()
    const timings: TimingData['timings'] = {}
    const timingData: TimingData = {
      timingStart,
      timings
    }

    pending.push({req, timingData})

    req.on('socket', (socket: import('net').Socket) => {
      timings.socket = now() - timingStart

      // `._connecting` was the old property which was made public in node v6.1.0
      type SocketInternal = import('net').Socket & {_connecting?: number}
      const isConnecting = (socket as SocketInternal)._connecting || socket.connecting
      if (!isConnecting) return

      const onLookupTiming = () => {
        timings.lookup = now() - timingStart
      }
      const onConnectTiming = () => {
        timings.connect = now() - timingStart
      }

      socket.once('lookup', onLookupTiming)
      socket.once('connect', onConnectTiming)

      // clean up timing event listeners if needed on error
      req.once('error', () => {
        socket.removeListener('lookup', onLookupTiming)
        socket.removeListener('connect', onConnectTiming)
      })
    })

    req.on('response', () => {
      timings.response = now() - timingStart
    })

    // TODO: handle errors
  })

  axiosExt.interceptors.response.use((resp) => {
    const i = pending.findIndex((entry) =>
      entry.req._currentRequest === resp.request || entry.req === resp.request
    )

    if (i < 0) return resp

    const timingData = pending.splice(i, 1)[0].timingData

    timingData.timings.end = now() - timingData.timingStart

    // fill in the blanks for any periods that didn't trigger, such as
    // no lookup or connect due to keep alive
    if (!timingData.timings.socket) {
      timingData.timings.socket = 0
    }
    if (!timingData.timings.lookup) {
      timingData.timings.lookup = timingData.timings.socket
    }
    if (!timingData.timings.connect) {
      timingData.timings.connect = timingData.timings.lookup
    }
    if (!timingData.timings.response) {
      timingData.timings.response = timingData.timings.connect
    }

    return {
      ...resp,
      ...timingData
    }
  })
}

export interface AxiosInstanceExtended extends AxiosInstance {
  interceptors: AxiosInstance['interceptors'] & {
    httpRequest: SyncInterceptorManager<http.ClientRequest>
    httpResponse: SyncInterceptorManager<http.IncomingMessage>
  }
}

interface CallbackInterceptor<V> {
  fulfilled?(value: V): V | undefined
}

interface SyncInterceptorManager<V> {
  use(onFulfilled?: (value: V) => V | void): number
  eject(id: number): void
  forEach(fn: (interceptor: CallbackInterceptor<V>) => void): void
}

// tslint:disable-next-line:variable-name
const SyncInterceptorManager = InterceptorManager as {
  new<V>(): SyncInterceptorManager<V>
}

export function hasHttpInterceptors(axios: AxiosInstance): axios is AxiosInstanceExtended {
  const interceptors = axios.interceptors as Partial<AxiosInstanceExtended['interceptors']>

  return Boolean(interceptors.httpRequest && interceptors.httpResponse)
}

const isHttps = /https:?/
export function setupAxiosHttpInterceptors(axios: AxiosInstance): AxiosInstanceExtended {
  if (hasHttpInterceptors(axios)) return axios

  const axiosExtended = axios as AxiosInstanceExtended
  axiosExtended.interceptors.httpRequest = new SyncInterceptorManager()
  axiosExtended.interceptors.httpResponse = new SyncInterceptorManager()

  const requestInterceptors = axiosExtended.interceptors.request as AxiosInterceptorManager<httpAdapter.Config>
  requestInterceptors.use((config) => {
    const parsed = url.parse(config.url!)
    // tslint:disable-next-line:no-http-string
    const protocol = parsed.protocol || 'http:'

    const proxy = config.proxy
    const isHttpsRequest = isHttps.test(protocol)
    // tslint:disable-next-line:no-uninitialized
    let rawTransport: httpAdapter.Transport
    const isHttpsProxy = isHttpsRequest && (proxy ? isHttps.test(proxy.protocol || '') : true);

    let isFollow = false
    if (config.transport) {
      rawTransport = config.transport;
    } else if (config.maxRedirects === 0) {
      rawTransport = isHttpsProxy ? https : http;
    } else {
      isFollow = true
      rawTransport = isHttpsProxy ? httpsFollow : httpFollow;
    }

    const transport: httpAdapter.Transport = {
      request(options: HttpFollowRequestOptions, requestCb) {
        if (isFollow && config.maxRedirects) {
          options.maxRedirects = config.maxRedirects
        }
        let req = rawTransport.request(options, (res) => {
          requestCb(res)
          axiosExtended.interceptors.httpResponse.forEach((interceptor) => {
            if (interceptor.fulfilled) {
              // tslint:disable-next-line:no-parameter-reassignment
              res = interceptor.fulfilled(res) || res
            }
          })
        })
        axiosExtended.interceptors.httpRequest.forEach((interceptor) => {
          if (interceptor.fulfilled) {
            req = interceptor.fulfilled(req) || req
          }
        })

        return req
      }
    }

    return {...config, transport}
  })

  return axiosExtended
}
