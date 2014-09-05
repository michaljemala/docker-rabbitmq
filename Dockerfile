FROM ubuntu:14.04
MAINTAINER Michal Jemala <michal.jemala@gmail.com>

RUN apt-get -qq update > /dev/null
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install curl > /dev/null
RUN curl -s http://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add -
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get -qq update > /dev/null
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install rabbitmq-server > /dev/null
RUN service rabbitmq-server stop

RUN rabbitmq-plugins enable rabbitmq_management
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config 

EXPOSE 5672 15672
