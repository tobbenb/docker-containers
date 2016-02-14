#!/bin/bash
#Install script for applications
#Oscam


#Change uid & gid to match Unraid
usermod -u 99 nobody
usermod -g 100 nobody
addgroup --gid 16 creader
usermod -g 16 nobody
usermod -d /home nobody 
chown -R nobody:users /home


#####################################
#	Install dependencies			#
#									#
#####################################

apt-get update -qq
apt-get install -qy --no-install-recommends \
				build-essential libpcsclite-dev libssl-dev libusb-dev libusb-1.0 openssl subversion \
				libpcsclite1 \
				pcscd pcsc-tools \
				usbutils
				
#####################################
#	Compile and install				#
#	oscam							#
#####################################
cd /tmp && \
svn checkout http://www.streamboard.tv/svn/oscam/trunk oscam-svn
pushd /tmp/oscam-svn 
./config.sh --enable all --disable HAVE_DVBAPI IPV6SUPPORT LCDSUPPORT LEDSUPPORT READ_SDT_CHARSETS CARDREADER_DB2COM CARDREADER_STAPI CARDREADER_STAPI5 CARDREADER_STINGER CARDREADER_INTERNAL CARDREADER_INTERNAL
make OSCAM_BIN=/usr/bin/oscam NO_PLUS_TARGET=1 CONF_DIR=/config pcsc-libusb
popd

#####################################
#	Add init scripts				#
#									#
#####################################

mkdir -p /etc/service/oscam
cat <<'EOT' > /etc/service/oscam/run
#!/bin/bash
exec /sbin/setuser nobody /usr/bin/oscam
EOT
chmod +x /etc/service/oscam/run

mkdir -p /etc/service/pcscd
cat <<'EOT' > /etc/service/pcscd/run
#!/bin/bash
exec /usr/sbin/pcscd
EOT
chmod +x /etc/service/pcscd/run

#####################################
#	Remove unneeded packages		#
#									#
#####################################

apt-get purge -qq build-essential subversion g++ g++-4.8 libapr1 libaprutil1 libserf-1-1 libstdc++-4.8-dev libsvn1 && apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/oscam-svn
