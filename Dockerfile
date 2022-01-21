FROM openjdk:17

LABEL maintainer="balhoff@renci.org"

RUN mkdir /blazegraph \
&& cd /blazegraph \
&& curl -L -O 'https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.jar' \
&& curl -L -O 'https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-servlets/9.2.3.v20140905/jetty-servlets-9.2.3.v20140905.jar'

ADD readonly_cors.xml /blazegraph/readonly_cors.tmp.xml
ADD entrypoint.sh /blazegraph/entrypoint.sh

RUN chmod +x /blazegraph/entrypoint.sh

# create the mount point for configuration files
RUN mkdir /data

# use --env on the docker run command line to override
ENV BLAZEGRAPH_MEMORY="8G"
ENV BLAZEGRAPH_TIMEOUT="60000"
ENV BLAZEGRAPH_READONLY="true"

# the port on which owlery will be listening within the container
EXPOSE 8080

# By default, a writable working directory is expected,
# containing blazegraph.properties and blazegraph.jnl
WORKDIR /data

ENTRYPOINT ["/blazegraph/entrypoint.sh"]
