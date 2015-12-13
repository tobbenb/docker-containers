FROM phusion/baseimage:0.9.17
MAINTAINER tobbenb <torbjornbrekke@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Change uid & gid to match Unraid
RUN usermod -u 99 nobody && \
    usermod -g 100 nobody
ADD xmltv-0.5.67.tar.bz2 /tmp/

# Install dependencies, build and install tvheadend
RUN apt-get update -qq && \
apt-get install -qy --no-install-recommends \
build-essential pkg-config libssl-dev git bzip2 wget \
libavahi-client-dev zlib1g-dev libcurl4-gnutls-dev python \
liburiparser1 liburiparser-dev gettext \
libhdhomerun-dev dvb-apps \
libarchive-zip-perl libdata-dump-perl libdate-manip-perl libdatetime-format-iso8601-perl libdatetime-format-strptime-perl \
libdatetime-perl libdatetime-timezone-perl libhtml-parser-perl libhtml-tableextract-perl libhtml-tree-perl \
libhttp-cache-transparent-perl libio-compress-perl libio-stringy-perl libjson-perl libparse-recdescent-perl \
libsoap-lite-perl libterm-readkey-perl libtext-bidi-perl libtext-iconv-perl libwww-mechanize-perl \
libwww-perl libxml-dom-perl libxml-libxml-perl libxml-libxslt-perl libxml-parser-perl libxml-twig-perl \
libxml-writer-perl libxmltv-perl perl perl-modules libxml-treepp-perl liblingua-en-numbers-ordinate-perl && \
cd /tmp && git clone https://github.com/tvheadend/tvheadend.git && cd tvheadend && \
git checkout d301e315 && ./configure --enable-libffmpeg_static && make && make install && \
cd /tmp/xmltv-0.5.67 && /bin/echo -e "yes" | perl Makefile.PL && make && make test && make install && \
rm -r /tmp/tvheadend && apt-get purge -qq build-essential pkg-config git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 9981 9982

VOLUME /config \
       /recordings \
	   /data

# Add tv_grab_wg to /usr/local/bin/
ADD tv_grab_wg tv_grab_file /usr/local/bin/
RUN chmod +x /usr/local/bin/tv_grab_*
ADD startup.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/startup.sh

#Start tvheadend when container starts
RUN mkdir -p /etc/service/tvheadend
ADD tvheadend /etc/service/tvheadend/run
RUN chmod +x /etc/service/tvheadend/run

#Add ffmpeg to /usr/bin/
ADD ffmpeg.gz /usr/bin/
