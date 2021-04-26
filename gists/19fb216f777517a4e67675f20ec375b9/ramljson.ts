interface RAMLResource {
  relativeUri: string
  methods: RAMLMethod[]
  resources?: RAMLResource[]
  displayName: string
  relativeUriPathSegments: string[]
  absoluteUri: string
}

interface RAMLMethod {
  responses: {[code: string]: RAMLResponse}
  protocols: string[]
  queryParameters: {[name: string]: RAMLQueryParameter}
  description: string
  method: string
}

interface RAMLResponse {
  code: string
  body: {[contentType: string]: RAMLResponseContent}
}
interface RAMLResponseContent {
  name: string
  schema: string
  example: string
  schemaContent: string
}
interface RAMLQueryParameter {
  name: string
  displayName: string
  type: string
  required: boolean
  repeat: boolean
  description: string
}