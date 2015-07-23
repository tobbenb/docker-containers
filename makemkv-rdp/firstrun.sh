#!/bin/bash

#Link to Makemkv config folder
mkdir -p /config/config
ln -s /config/config /nobody/.MakeMKV
chown -R nobody:users /config
chmod -R g+rw /config

#Add nobody to cdrom group
addgroup --gid 19 makemkv
usermod -g 19 nobody
