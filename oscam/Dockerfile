FROM phusion/baseimage:0.9.16
MAINTAINER tobbenb <torbjornbrekke@gmail.com>

#Disable the SSH server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Change uid & gid to match Unraid
RUN usermod -u 99 nobody && \
    usermod -g 100 nobody && \
	addgroup --gid 16 creader && \
	usermod -g 16 nobody && \
    usermod -d /home nobody && \
    chown -R nobody:users /home

RUN apt-get update -qq && \
    apt-get install -qy \
	libpcsclite1 \
	pcscd pcsc-tools \
    usbutils && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
 

#Add service to start oscam
ADD oscam.sh /etc/service/oscam/run
RUN chmod +x /etc/service/oscam/run
ADD oscam /usr/bin/
RUN chmod +x /usr/bin/oscam

EXPOSE 8888

VOLUME /config
