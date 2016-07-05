#!/bin/bash

#Check if nonexistent folder exists and create if needed
if [ ! -d /nonexistent ]; then
  mkdir -p /nonexistent/
fi
  
#Check if xmltv folder exists
if [ ! -d /config/.xmltv ]; then
  mkdir -p /config/.xmltv
fi

#Check if link exists
if [ ! -h /config/.xmltv ]; then
  ln -s  /config/.xmltv /nonexistent/
fi

#Add default recording path if no config exists
if [ ! -d /config/dvr/config ]; then
	echo Creating default DVR config...
	mkdir -p /config/dvr/config
	cp /7a5edfbe189851e5b1d1df19c93962f0 /config/dvr/config/7a5edfbe189851e5b1d1df19c93962f0
fi

chown -R nobody:users /config/.xmltv
chmod -R g+rw /config/.xmltv
