FROM phusion/baseimage:0.9.18
MAINTAINER tobbenb <torbjornbrekke@gmail.com>

# Set correct environment variables.
ENV HOME="/root" DEBIAN_FRONTEND="noninteractive" TERM="xterm"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Add install files
ADD ./files/ /tmp/

#Install application and remove install files after
RUN chmod +x /tmp/install/install.sh && sleep 1 && /tmp/install/install.sh && rm -r /tmp/install

EXPOSE 8888

VOLUME /config
