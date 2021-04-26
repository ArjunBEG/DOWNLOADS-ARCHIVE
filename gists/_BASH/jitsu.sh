λ ~work/photopipe/ master* jitsu deploy
info:    Welcome to Nodejitsu joemccann
info:    It worked if it ends with Nodejitsu ok
info:    Executing command deploy
info:    Analyzing your application dependencies in node app.js
warn:    Local version appears to be old
warn:    Your package.json version will be incremented for you automatically
warn:    About to write /Users/joemccann/Documents/workspace/photopipe/package.json
warn:    Using '*' as version for dependencies may eventually cause issues.
warn:    Please use specific versions for dependencies to avoid future problems.
data:    
data:    {
data:        scripts: { start: 'node app.js' },
data:        name: 'photopipe',
data:        keywords: [
data:            'photo',
data:            'pipe',
data:            'photopipe',
data:            'image',
data:            'stream',
data:            'restful',
data:            'images',
data:            'upload',
data:            'api'
data:        ],
data:        repository: { url: 'git://github.com/joemccann/photopipe', type: 'git' },
data:        engines: { node: '0.8.x' },
data:        domains: [ 'photopi.pe', 'www.photopi.pe' ],
data:        dependencies: {
data:            request: '>=2.9.203',
data:            instagram-node-lib: '>=0.0.9',
data:            express: '3.0.0rc3',
data:            ejs: '*',
data:            stylus: '*',
data:            html-minifier: '>=0.4.5'
data:        },
data:        subdomain: 'photopipe',
data:        version: '0.0.2-4',
data:        author: { name: 'Joe McCann', email: 'joe@subprint.com' },
data:        description: 'Pipe yer photos all over the web and stuff.',
data:        contributors: [
data:            { name: 'Joe McCann', email: 'joe@subprint.com' }
data:        ]
data:    }
data:    
prompt: Is this ok?: (yes) 
info:    Creating snapshot 0.0.2-4
info:    Updating app photopipe
info:    Activating snapshot 0.0.2-4 for photopipe
info:    Starting app photopipe
error:   Error running command deploy
error:   Nodejitsu Error (500): Internal Server Error
warn:    Error returned from Nodejitsu
error:   Error: connect ECONNREFUSED
error:       at errnoException (net.js:768:11)
error:       at Object.afterConnect [as oncomplete] (net.js:759:19)
info:    Nodejitsu not ok