FROM node:7.9.0-alpine
MAINTAINER Falco Prescher

LABEL version="0.1"
LABEL description="Hosting a simple Angular4 app with express"

ENV "PROJECTDIR"="/app"

WORKDIR $PROJECTDIR

# COPY wwwroot $PROJECTDIR/wwwroot
COPY src $PROJECTDIR/src
COPY server.js $PROJECTDIR
COPY package.json $PROJECTDIR
COPY webpack.config.js $PROJECTDIR
COPY tsconfig.json $PROJECTDIR

RUN ["mkdir", "wwwroot"]
COPY wwwroot/index.html $PROJECTDIR/wwwroot

RUN ["npm", "install"]
RUN ["npm", "run", "build"]
# RUN ["npm", "install", "--only=prod"]

EXPOSE 8080

ENTRYPOINT ["npm"]

CMD ["run", "serve"]
