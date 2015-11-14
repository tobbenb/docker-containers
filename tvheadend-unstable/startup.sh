#!/bin/bash

#Check if nonexistent folder exists and create if needed
if [ ! -d /nonexistent ]; then
  mkdir -p /nonexistent
fi
  
#Link to xmltv config folder
mkdir -p /config/.xmltv
ln -s /config/.xmltv /nonexistent/.xmltv
chown -R nobody:users /config
chmod -R g+rw /config
