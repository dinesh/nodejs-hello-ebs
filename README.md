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

We have created our node.js hello world application. Now let's try to dockerize it. 

Let's create a docker file and save it as Dockerfile to build an image of our hello world application.
```sh
FROM	ubuntu:14.04
RUN 	apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists
RUN		curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN		apt-get update && apt-get install -y nodejs 

COPY	package.json /src/package.json
RUN		cd /src; npm install --production
COPY	. /src

EXPOSE  3000
CMD		["node", "/src/server.js"]
```
In this Dockerfile,
- First line, docker uses ubuntu 14:04 as the operating system
- Second line, it installs curl
- 3rd and 4th line install nodejs with version 5.x 
(Instead of first 3 lines, one can also use a pre-built image of nodejs. For that replace first 3 lines with: FROM shubhag/nodejs)
- Next line copy package.json file into docker image
- 7th line, runs npm install to install the node dependencies.
- Next line copies the source server file into docker images (. implies everything  in the current folder)
- Last 2 lines, expose port 3000 and specify the command to run nodejs server.

Now, let's build this image using
```sh
$ docker build -t hello-world .
```
-t parameter here specifies the name for the image (you can give any name)

Finally to run the docker container using the previously build image, use
```sh
$ docker run -p 3000:3000 -d --name server hello-world
```
Now, open [localhost:3000] in your browser. Voila, you have dockerized your node.js hello world application.

[localhost:3000]: <http://localhost:3000>