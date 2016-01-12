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

chown -R nobody:users /config/.xmltv
chmod -R g+rw /config/.xmltv
