FROM alpine:latest

LABEL MAINTAINER Theodor A. Dumitrescu 

ENV TOMCAT /usr/local/tomcat
ENV PATH $TOMCAT/bin:$PATH

ENV TOMCAT_REMOTE_ACCESS 1
ENV TOMCAT_USER admin
ENV TOMCAT_PASSWORD admin

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

RUN mkdir -p ${TOMCAT}
WORKDIR $TOMCAT


RUN apk add --no-cache openjdk8 \
    && apk add --no-cache wget \
    && wget https://apache.panu.it/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz \
    && tar xvzf apache-tomcat-8.5.51.tar.gz --strip-components 1 \
    && rm apache-tomcat-8.5.51.tar.gz

COPY config/tomcat-users.xml ${TOMCAT}/conf
#RUN sh ${TOMCAT}/bin/catalina.sh start

# We are going to run Tomcat for creating the default configuratoin files which then we are going to modify
RUN sh catalina.sh start \
    && sleep 1 \
    && sh catalina.sh stop -force \
    && sed -1 "s/<Valve/<--Valve/; s/[0,:]*1\" \/>/0:0:0:0:0:0:0:1\" \/-->/" webapps/manager/META-INF/context.xml \
    && sed -1 "s/<Valve/<--Valve/; s/[0,:]*1\" \/>/0:0:0:0:0:0:0:1\" \/-->/" webapps/host-manager/META-INF/context.xml

EXPOSE 8080
ENTRYPOINT /bin/sh bin/catalina.sh run