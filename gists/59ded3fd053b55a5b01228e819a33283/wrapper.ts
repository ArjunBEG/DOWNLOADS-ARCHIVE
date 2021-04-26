type Method = 'get' | 'post' | 'put' | 'delete'
type Handler = (req: Request) => Promise<any>

function route (method: Method, path: string, handler: Handler) {
  app[method](path, (req, res, next) => {
    handler(req)
      .then(result => result ? res.json(result) : res.status(204).end(''))
      .catch(next)
  })
}

route('post', '/test', async () => {})