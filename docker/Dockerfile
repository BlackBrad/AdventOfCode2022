FROM ubuntu:22.04

RUN apt update
RUN apt upgrade -y
RUN apt install build-essential -y
RUN apt install make -y
RUN apt install gfortran -y
RUN apt install gnucobol -y
RUN apt install wget -y
RUN apt install unzip -y

RUN wget -P /tmp http://www.nicholson.com/rhn/files/cbas367b5-linux-x86_64.zip
RUN cd /tmp && unzip cbas367b5-linux-x86_64.zip
RUN cp /tmp/basic /usr/local/bin
