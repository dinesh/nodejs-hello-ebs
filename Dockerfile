FROM	ubuntu:14.04
RUN 	apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists
RUN		curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN		apt-get update && apt-get install -y nodejs 

COPY	package.json /src/package.json
RUN		cd /src; npm install --production
COPY	. /src

EXPOSE  3000
CMD		["node", "/src/server.js"]