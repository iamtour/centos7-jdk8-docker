# use the centos base image
FROM centos:7
MAINTAINER Tour He, hetaohai@qq.com

# TODO: download the JDK to your local jdk/jdk-8-linux-x64.rpm before build the docker, refer to http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html
ADD jdk/jdk-8-linux-x64.rpm /tmp/jdk-8-linux-x64.rpm

RUN yum -y install /tmp/jdk-8-linux-x64.rpm

RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest

RUN mkdir -p /opt/lion/logs

#start files
ADD start.sh /opt/lion
RUN chmod +x /opt/lion/start.sh

#set timezone to HK
RUN rm /etc/localtime -rf
RUN ln -s /usr/share/zoneinfo/Hongkong /etc/localtime

#auto start
RUN ln -s /opt/lion/start.sh /etc/profile.d/start.sh

#java ports
EXPOSE 8080 8081 8787

VOLUME ["/opt/lion/logs"]