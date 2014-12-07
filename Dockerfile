FROM phusion/baseimage:0.9.15
MAINTAINER tobbenb <torbjornbrekke@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Change uid & gid to match Unraid
RUN usermod -u 99 nobody && \
	usermod -g 100 nobody
	
RUN apt-get install -qy curl
RUN curl http://apt.tvheadend.org/repo.gpg.key | sudo apt-key add -
RUN apt-add-repository http://apt.tvheadend.org/unstable
RUN apt-get update -qq
RUN echo "tvheadend tvheadend/admin_username select admin" | /usr/bin/debconf-set-selections
RUN echo "tvheadend tvheadend/admin_password select password" | /usr/bin/debconf-set-selections
RUN apt-get install -qy tvheadend
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9981 9982

VOLUME /config
VOLUME /recordings

#Start tvheadend when container starts
RUN mkdir -p /etc/my_init.d
ADD tvheadend /etc/my_init.d/tvheadend
RUN chmod +x /etc/my_init.d/tvheadend
