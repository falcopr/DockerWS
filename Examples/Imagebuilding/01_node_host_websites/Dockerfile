FROM node:7.9.0-alpine
MAINTAINER Falco Prescher

LABEL version="0.1"
LABEL description="Hosting a simple Angular4 app with express"

ENV "PROJECTDIR"="/webapps"

WORKDIR $PROJECTDIR

COPY wwwroot $PROJECTDIR/wwwroot
COPY webserver.js $PROJECTDIR
COPY package.json $PROJECTDIR

RUN ["npm", "install", "--only=prod"]

EXPOSE 8080

ENTRYPOINT ["npm"]

CMD ["run", "serve"]
