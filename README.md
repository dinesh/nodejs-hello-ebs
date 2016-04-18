# docker-nodejs-webapp

It is a simple hello world application to get to know about docker and nodejs. In the first part, we will create a simple nodejs web application and then we will build a docker image for the web application and lastly we will push the docker image on dockerhub.

### Node.js hello world

Make sure to have node.js installed on your system. If not, install it from https://nodejs.org/en/download/package-manager/

Create a server.js file and insert the below given code in it.
```sh
var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
```
Let's try to understand what we are trying to do with these sets of instructions.
- First 2 lines instruct the nodejs application that it requires express module and initialise it in app variable.
- Next 3 lines takes GET request at '/' path and reponds with "Hello World!".
- In the last 3 lines, app listens on port 3000 for connections.

Now let's initialize package.json to list all the dependencies needed for the server to run.

```sh
{
  "name": "docker_helloworld",
  "version": "1.0.0",
  "description": "Docker Node.js hello world web application",
  "author": "First-name last-name <email>",
  "dependencies": {
    "express": "^4.13.4"
  }
}
```
In the package.json, we have listed express module and its latest version. Name, version, description and author are optional parameters. Now let us install the dependencies using 
```sh
$ npm install
```
Finally, start the server using 
```sh
$ node server.js
```
Open [localhost:3000] on your browser. Here you will get a "Hello world" message.

### Dockerizing Node.js helloworld application