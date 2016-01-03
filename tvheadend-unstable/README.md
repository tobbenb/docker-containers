tvheadend-unstable
==================

Docker container for tvheadend unstable build. This is work in progress and it might change or disappear without notice. It was created for use with Unraid v6. Tvheadend is running as nobody/users so the permissions for written files are correct.

To run this docker use this command:

docker run -d –-name="tvheadend" -v /path/to/your/config:/config \
		   -v /path/to/your/recordings:/recordings \
		   -v /etc/localtime:/etc/localtime:ro \
		   -p 9981:9981 -p 9982:9982 \
		   tobbenb/tvheadend-unstable

If you use IPTV or other IP based reception you have to add the ports to the start command. So if you have IPTV over udp that uses port 5500 you simply add this: -p 5500:5500

If you do not know which ports to passthrough you can add –net=“host” after -d and remove all port passthrough -p 1234:1234

It's built from git and have transcoding and HDHomerun enabled.

