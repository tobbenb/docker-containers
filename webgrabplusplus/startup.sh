#!/bin/sh
#Create links for wget so grabbing works.
ln -sf /wg++/wget.exe /config/wget.exe
ln -sf /wg++/wget.bat /config/wget.bat

#Check if Webgrab++ config file exists in config folder. Copy to config if not existing.
if [ ! -f /config/WebGrab++.config.xml ]; then
  cp /wg++/WebGrab++.config.xml /config/
fi

#Check if ini example file exist, if not copy it to config
if [ ! -f /config/se.timefor.tv.ini ]; then
  cp /wg++/se.timefor.tv.ini /config/
fi

#Check if Ini folder exists in config folder. Copy to config if not existing.
if [ ! -d /config/ini ]; then
  cp -R /wg++/ini /config/
fi

#Check if mdb folder exists in config folder. Copy to config if not existing.
if [ ! -d /config/mdb ]; then
  cp -R /wg++/mdb /config/
fi

#Check if rex folder exists in config folder. Copy to config if not existing.
if [ ! -d /config/rex ]; then
  cp -R /wg++/rex /config/
fi

#Check if user modified cron file exists and move to wg++.
if [ -e /config/mycron ]; then
  crontab -u nobody /config/mycron
fi

#Change owner for config files and guide.xml
chown -R nobody:users /config
chown -R nobody:users /data

#Start an update on container start if config file exist
if [ -f /config/WebGrab++.config.xml ]; then
  sudo -u nobody /wg++/update.sh
fi
