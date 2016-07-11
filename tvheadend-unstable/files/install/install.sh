#!/bin/bash
#Install script for applications
#Tvheadend-unstable


#Change uid & gid to match Unraid
usermod -u 99 nobody
usermod -g 100 nobody

#####################################
#	Install dependencies			#
#									#
#####################################

apt-get update -qq
apt-get install -qy --no-install-recommends \
				build-essential pkg-config libssl-dev git bzip2 wget cmake\
				libavahi-client-dev zlib1g-dev libcurl4-gnutls-dev python \
				liburiparser1 liburiparser-dev gettext \
				libhdhomerun-dev dvb-apps \
				libarchive-zip-perl libdata-dump-perl libdate-manip-perl libdatetime-format-iso8601-perl libdatetime-format-strptime-perl \
				libdatetime-perl libdatetime-timezone-perl libhtml-parser-perl libhtml-tableextract-perl libhtml-tree-perl \
				libhttp-cache-transparent-perl libio-compress-perl libio-stringy-perl libjson-perl libparse-recdescent-perl \
				libsoap-lite-perl libterm-readkey-perl libtext-bidi-perl libtext-iconv-perl libwww-mechanize-perl \
				libwww-perl libxml-dom-perl libxml-libxml-perl libxml-libxslt-perl libxml-parser-perl libxml-twig-perl \
				libxml-writer-perl libxmltv-perl perl perl-modules libxml-treepp-perl liblingua-en-numbers-ordinate-perl


#####################################
#	Compile and install				#
#	tvheadend						#
#####################################

pushd /tmp/
git clone https://github.com/tvheadend/tvheadend.git 
popd
pushd /tmp/tvheadend
git checkout f34fac1a 
./configure --enable-libffmpeg_static
make 
make install
popd

#####################################
#	Compile and install				#
#	xmltv							#
#####################################
pushd /tmp/install/
tar xvjf xmltv-0.5.67.tar.bz2
popd
pushd /tmp/install/xmltv-0.5.67 
/bin/echo -e "yes" | perl Makefile.PL 
make 
make test 
make install 
popd

#####################################
#	Copy config files				#
#									#
#####################################

cp /tmp/install/tv_grab_wg /usr/local/bin/tv_grab_wg
cp /tmp/install/tv_grab_file /usr/local/bin/tv_grab_file
chmod +x /usr/local/bin/tv_grab_*
cp /tmp/config/startup.sh /etc/my_init.d/
chmod +x /etc/my_init.d/startup.sh
mkdir -p /etc/service/tvheadend
cp /tmp/config/tvheadend /etc/service/tvheadend/run
chmod +x /etc/service/tvheadend/run

gunzip -v /tmp/install/ffmpeg.gz
cp /tmp/install/ffmpeg /usr/bin/
cp /tmp/install/7a5edfbe189851e5b1d1df19c93962f0 /7a5edfbe189851e5b1d1df19c93962f0
chmod +x /7a5edfbe189851e5b1d1df19c93962f0

#####################################
#	Remove unneeded packages		#
#									#
#####################################

rm -r /tmp/tvheadend && apt-get purge -qq build-essential pkg-config git cmake && apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*
