# CouchDB Docker Guide

## How to start

1. ./run.ps1 "create:image"
2. ./run.ps1 "start:container"
3. Go to futon: <ip-of-docker-machine>:8082/_utils/
4. Do setup and set
* Password
* Single Node Setup
5. Set credentials by environment variable through the following command
* $CouchHost="http://<username>:<password>@<ip-of-docker-machine>:8082"
* For example: $CouchHost="http://hallo123:hallo123@192.168.178.42:8082"
* Use this for any CouchDB Query: curl -X PUT $CouchHost....

## How to stop and remove

1. ./run.ps1 "stop:container"
2. ./run.ps1 "remove:container"

## How to query the database


## How to access futon

* <ip-of-docker-machine>:8082/_utils/

## How to create database

* curl -X PUT <ip-of-docker-machine>:8082/<database-name>

## View all databases

* curl -X PUT <ip-of-docker-machine>:8082/_all_dbs

## Query data

### Get all docs
* curl -X GET <ip-of-docker-machine>:8082/<database-name>/_all_docs

### Get only by design document view
* curl -X GET <ip-of-docker-machine>:8082/<database-name>/<design-document-name>/_view/<view-name>

## How to create structure and create data

1. Create data
* Each data should include at least a type-attribute. The view uses this to distinguish the data types.
2. Create a design document (provides you with a view and a REST API)

### Create data

1. Call the following and change the JSON-content
* curl.exe -X POST -H "Content-type: application/json" <ip-of-docker-machine>:8082/<database-name> -d '{ \"type\": \"person\", \"name\": \"<your name>\" }'
* For example: curl.exe -X POST -H "Content-type: application/json" $CouchHost/test -d '{ \"type\": \"person\", \"name\": \"Falco\" }'

### Create design document with view

1. Call the following and change the JSON for adding the mapping function (view)
* curl -X PUT $CouchHost/<database_name>/_design/<collection> --data-binary @mydesign.json
* For example: curl -X PUT $CouchHost/test/_design/person --data-binary @person.dd.json
2. Query data for testing: curl -X GET $CouchHost/test/_design/person/_view/person

## References

* Guide to CouchDB - http://guide.couchdb.org/draft/documents.html
* Exporting CouchDB data - http://www.greenacorn-websolutions.com/couchdb/export-import-a-database-with-couchdb.php
* Import CouchDB data - 
https://stackoverflow.com/questions/37015279/posting-multiple-documents-to-couchdb-with-curl
* Mango Query Language - 
https://github.com/cloudant/mango
* CouchDB Documentation - 
http://docs.couchdb.org/en/2.0.0/api/database/bulk-api.html
* CouchDB HTTP documentation API - 
https://wiki.apache.org/couchdb/HTTP_Document_API