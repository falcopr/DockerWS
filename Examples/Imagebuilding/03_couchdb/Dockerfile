FROM klaemo/couchdb:2.0.0
MAINTAINER Falco Prescher

LABEL version="0.1"
LABEL description="Hosting a CouchDB"

# EXPOSE 5984 4369 9100
# VOLUME ["/opt/couchdb/data"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["/opt/couchdb/bin/couchdb"]
