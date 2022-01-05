#!/bin/bash

PROPERTIES=$1

sed "s/@@TIMEOUT@@/$BLAZEGRAPH_TIMEOUT/" /blazegraph/readonly_cors.tmp.xml | sed "s/@@READONLY@@/$BLAZEGRAPH_READONLY/" >/blazegraph/readonly_cors.xml

java -Xmx$BLAZEGRAPH_MEMORY -Dfile.encoding=UTF-8 -Djetty.port=8080 -Djetty.overrideWebXml=/blazegraph/readonly_cors.xml -Dbigdata.propertyFile=$PROPERTIES -cp /blazegraph/blazegraph.jar:/blazegraph/jetty-servlets-9.2.3.v20140905.jar com.bigdata.rdf.sail.webapp.StandaloneNanoSparqlServer
