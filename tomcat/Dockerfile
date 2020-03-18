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

EXPOSE 8080
ENTRYPOINT /bin/sh bin/catalina.sh run