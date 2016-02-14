Docker container for Oscam. This was made for use on Unraid.

Start it by running:
docker run -d --name=oscam --device=/dev/ttyUSB0 -v /mnt/cache/appdata/test/oscam/:/config -p 8888:8888 -v /etc/localtime:/etc/localtime:ro tobbenb/oscam-svn
