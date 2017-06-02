FROM node:7.9.0-alpine
MAINTAINER Falco Prescher

LABEL version="0.1"
LABEL description="Hosting a simple REST API with express"

ENV "PROJECTDIR"="/app"

WORKDIR $PROJECTDIR

COPY app $PROJECTDIR/app
COPY server.js $PROJECTDIR
COPY package.json $PROJECTDIR

RUN ["npm", "install", "--only=prod"]

EXPOSE 8081

ENTRYPOINT ["npm"]

CMD ["run", "serve"]
