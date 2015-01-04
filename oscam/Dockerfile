FROM phusion/baseimage:0.9.15
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
    usermod -d /home nobody && \
    chown -R nobody:users /home

RUN apt-add-repository "deb http://ppa.launchpad.net/oscam/ppa/ubuntu trusty main" && \
    gpg --keyserver keyserver.ubuntu.com --recv-keys 651987A2BDBE1D1E && gpg --export --armor 651987A2BDBE1D1E | apt-key add - && \
    apt-get update -qq && \
    apt-get install -qy oscam-svn

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

#Add service to start oscam
ADD oscam.sh /etc/service/oscam/run
RUN chmod +x /etc/service/oscam/run

EXPOSE 8888 10000 10001 10002 10003 10004 10005 10006 10007 10008 10009 10010

VOLUME /config
