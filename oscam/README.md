Docker container for Oscam-svn.

Start it by running:
docker run -d --name=oscam-svn --device=/dev/ttyUSB0:/dev/ttyUSB0 -v /mnt/cache/appdata/test/oscam/:/config -p 8888:8888 -v /etc/localtime:/etc/localtime:ro tobbenb/oscam-svn
