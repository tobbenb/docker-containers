#!/bin/bash

#Link to MKVToolNix config folder
mkdir -p /config/config
ln -s /config/config /nobody/.config/bunkus.org
chown -R nobody:users /config
chmod -R g+rw /config
