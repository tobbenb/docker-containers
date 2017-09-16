#!/bin/bash
#Install script for applications
#MakeMKV-RDP

#####################################
#	Install dependencies			#
#									#
#####################################

apt-get update -qq
apt-get install -qy build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev libqt4-dev wget

#####################################
#	Download sources and extract	#
#									#
#####################################
VERSION="1.10.7"

mkdir -p /tmp/sources
wget -O /tmp/sources/makemkv-bin-$VERSION.tar.gz http://www.makemkv.com/download/makemkv-bin-$VERSION.tar.gz
wget -O /tmp/sources/makemkv-oss-$VERSION.tar.gz http://www.makemkv.com/download/makemkv-oss-$VERSION.tar.gz
wget -O /tmp/sources/ffmpeg-2.8.tar.bz2 https://ffmpeg.org/releases/ffmpeg-2.8.tar.bz2
pushd /tmp/sources/
tar xvzf /tmp/sources/makemkv-bin-$VERSION.tar.gz
tar xvzf /tmp/sources/makemkv-oss-$VERSION.tar.gz
tar xvjf /tmp/sources/ffmpeg-2.8.tar.bz2
popd

#####################################
#	Compile and install				#
#									#
#####################################

#FFmpeg
pushd /tmp/sources/ffmpeg-2.8
./configure --prefix=/tmp/ffmpeg --enable-static --disable-shared --enable-pic --disable-yasm
make install
popd

#Makemkv-oss
pushd /tmp/sources/makemkv-oss-$VERSION
PKG_CONFIG_PATH=/tmp/ffmpeg/lib/pkgconfig ./configure
make
make install
popd

#Makemkv-bin
pushd /tmp/sources/makemkv-bin-$VERSION
/bin/echo -e "yes" | make install
popd


#####################################
#	Fix keyboard mappings rdp		#
#									#
#####################################
sed -i.bak '/[default_rdp_layouts]/ a rdp_layout_no=0x00000414' /etc/xrdp/xrdp_keyboard.ini
sed -i.bak '/[default_layouts_map]/ a rdp_layout_no=no' /etc/xrdp/xrdp_keyboard.ini
cp /tmp/install/keymaps/*.ini /etc/xrdp/

#####################################
#	Add configs and needed stuff	#
#									#
#####################################
cp /tmp/install/startapp.sh /startapp.sh
chmod +x /startapp.sh
cp /tmp/install/firstrun.sh /etc/my_init.d/firstrun.sh
chmod +x /etc/my_init.d/firstrun.sh

#####################################
#	Remove unneeded packages		#
#									#
#####################################

apt-get remove -qy build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev libqt4-dev
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

exit
