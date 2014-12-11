FROM phusion/baseimage:0.9.15
MAINTAINER tobbenb <torbjornbrekke@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Disable the SSH server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Set correct environment variables.
ENV HOME /root


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Change uid & gid to match Unraid
RUN usermod -u 99 nobody && \
    usermod -g 100 nobody

RUN curl http://apt.tvheadend.org/repo.gpg.key | sudo apt-key add - && \
    apt-add-repository http://apt.tvheadend.org/unstable && \
    apt-get update -qq && \
    echo "tvheadend tvheadend/admin_username select admin" | /usr/bin/debconf-set-selections && \
    echo "tvheadend tvheadend/admin_password select password" | /usr/bin/debconf-set-selections && \
    apt-get install -qy tvheadend

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

EXPOSE 9981 9982

VOLUME /config \
       /recordings

#Start tvheadend when container starts
RUN mkdir -p /etc/my_init.d
ADD tvheadend /etc/my_init.d/tvheadend
RUN chmod +x /etc/my_init.d/tvheadend
