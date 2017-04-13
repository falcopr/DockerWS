FROM debian:latest
MAINTAINER Falco Prescher

LABEL version="0.1"
LABEL description="This is a image for installing the latest debian"

ENV "HOMEDIR"="/home/server"
ENV "HOMEEXTERNALSDIR"=$HOMEDIR/externals
ENV "LOGDIR"="/var/log"

WORKDIR $HOMEDIR

VOLUME [$LOGDIR, $HOMEEXTERNALSDIR]

RUN touch $HOMEDIR/mynewfile.txt

ENTRYPOINT ["top"]

CMD ["-b"]
