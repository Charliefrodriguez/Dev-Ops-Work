FROM groovy:jdk11-alpine  
RUN mkdir groovy_work
WORKDIR groovy_work
USER root
RUN apk update
RUN apk add vim
