## From zero to microservice with 𝚫 now

The following guide will show you how to deploy a simple microservice written in JavaScript using [𝚫 now](https://zeit.co/now).

It uses Open Source tools that are widely available, tested and understood:

- Node.JS
- NPM
- Express

### Prerequisites

Make sure Node.JS is installed in your machine. If not, head to https://nodejs.org/en/ and download it and install it.

To execute the commands described in this guide, launch your preferred Terminal. On Mac OS X, you can locate "Terminal.app" under "Applications" > "Utilities".

To make sure Node.JS (which comes with `npm`) is properly installed, try running the command:

```
npm --version
```

It should look similar to this:

![](https://cloudup.com/cebs58aBhVA+)

#### Installing now

`now` is a tool that will immediately deploy any Node.JS HTTP service with all its files and dependencies to the cloud.

Install it with NPM as follows:

```
npm install -g now
```

To verify it's installed and it works run:

```
now --version
```

It should look similar to this:

![](https://cloudup.com/c4ZUmYsu8eg+)

### Creating your service

Create a fresh directory for it and go to it:

```bash
mkdir ~/my-service
cd ~/my-service
```

Every Node.JS project needs a `package.json` file. Create it with some basic information by copying and pasting this entire command:

```
cat <<EOF > package.json
{
  "name": "my-service",
  "version": "0.1.0",
  "dependencies": {}
}
EOF
```

To introduce a dependency, let's install express and save it to `package.json`:

```
npm install express@4.13.4 --save
npm install body-parser@1.15.0 --save
```

If you then look at the contents of `package.json`, it will look as follows:

![](https://cloudup.com/c6bN2x_Jg5U+)

### Writing your service

We'll first write a basic HTTP endpoint that accepts POST requests.

```bash
cat <<EOF > index.js
var app = require('express')();
var srv = require('http').createServer(app);
var bodyParser = require('body-parser');

app.post('/', function (req, res, next) {
  res.send('You POSTed to the micro-service!');
});

srv.listen(3000, function () {
  console.log('Listening on 3000');
});
EOF
```

If you run

```bash
node index
```

you should see that it's listening on port `3000`:

![](https://cloudup.com/cwpL9YhyyxX+)

In another instance of the terminal, try POSTing some data with the `curl` utility (you can also [learn more](https://gist.github.com/caspyin/2288960) about curl).

![](https://cloudup.com/ca0oi9Mo864+)

This service is ready to be deployed! Let's say that instead of `localhost`, which only works on your computer, you wanted to share your micro-service with co-workers or the world.

Simply run `now`! The first time you run it, it'll prompt you to log in or register. Just enter your email and watch your inbox.

After you click the link it emails you, notice that it will try to deploy:

![](https://cloudup.com/cCT5RT5yC8j+)

`now` has only one simple requirement: a `start` script must be defined in `package.json`. We can add it as follows:

```bash
cat <<EOF > package.json
{
  "name": "my-service",
  "version": "0.1.0",
  "dependencies": {
    "body-parser": "^1.15.0",
    "express": "^4.13.4"
  },
  "scripts": {
    "start": "node index"
  }
}
EOF
```

In this case, the `start` script will run the command we manually ran earlier, to make the HTTP service start.

Notice that `now` doesn't need to know about ports. Any port will work (including ephemeral ones!) as long as your service allows HTTP traffic.

![](https://cloudup.com/cD69_TiT_5z+)

When you enter `now`, it will give you a unique URL for that deployment. Normally, you get this URL even before the deployment is complete.

If you open it in a browser, you can see the progress of the _build_: the upload, the installation of dependencies and `npm start`.

In this case, the deployment happens in under a second!

### Making changes

Let's say you want to make some changes to the code you just wrote. In this example, I made it so a `name` field is expected as JSON input.

![](https://cloudup.com/caKMo02igl0+)

To deploy it, I simply type `now` again and I'll get a new URL.

And voila! I can now send parameters. Both my URLs still work. `now` never overwrites or throws away your work.

![](https://cloudup.com/cFatYEe9AqS+)

If you have any questions about this tutorial, please comment below!