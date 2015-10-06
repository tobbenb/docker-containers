FROM hurricane/dockergui:x11rdp1.2
MAINTAINER tobbenb <torbjornbrekke@gmail.com>
# Set environment variables

# User/Group Id gui app will be executed as
ENV USER_ID=99
ENV GROUP_ID=100

# Gui App Name
ENV APP_NAME MakeMKV
ENV TERM xterm

# Default resolution, change if you like
ENV WIDTH=1280
ENV HEIGHT=720

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install MakeMKV
ADD Makefile ask_eula.sh install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh

# Add scripts to container
ADD startapp.sh /startapp.sh
RUN chmod +x /startapp.sh
ADD firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh


VOLUME ["/config"]
EXPOSE 3389 8080
