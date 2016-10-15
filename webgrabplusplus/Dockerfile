FROM phusion/baseimage:0.9.19
MAINTAINER tobbenb <torbjornbrekke@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Disable the SSH server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Set correct environment variables.
ENV HOME /root


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Change uid & gid to match Unraid
RUN usermod -u 99 nobody && \
    usermod -g 100 nobody

RUN apt-add-repository multiverse && \
    apt-get update -qq && \
    apt-get install -qy mono-complete sudo unrar unzip wget

#Download and extract WG++ to correct paths
RUN mkdir wg++ && \
    wget -O /tmp/wg++.rar http://webgrabplus.com/sites/default/files/download/SW/V1.1.1/WebGrabPlusV1.1.1LINUX.rar && \
    unrar x /tmp/wg++.rar /wg++/ && \
    rm /tmp/wg++.rar && \
    mv /wg++/WebGrab+PlusV1.1.1LINUX/* /wg++/ && \
    mv /wg++/MDB/ /wg++/mdb && \
    mv /wg++/REX/ /wg++/rex && \
    rm /wg++/*.ini && \
    rm -R /wg++/exe
    
#Download update
RUN wget -O /tmp/update.zip http://webgrabplus.com/sites/default/files/download/sw/V1.1.1/upgrade/patchexe_57.zip && \
    unzip /tmp/update.zip -d /tmp/ && \
    mv /tmp/WebGrab+Plus.exe /wg++/ && \
    mv /tmp/xmltv.dll /wg++/

#Download Siteini.pack
RUN wget -O /tmp/ini.zip http://webgrabplus.com/sites/default/files/download/ini/SiteIni.Pack_2016.01.05_085448.zip && \
    unzip /tmp/ini.zip -d /wg++/ini/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

#Add scripts for crontab and config
ADD update.sh startup.sh mycron WebGrab++.config.xml se.timefor.tv.ini /wg++/
RUN chmod -R +x /wg++/ && \
    crontab -u nobody /wg++/mycron && \
    mkdir -p /etc/my_init.d && \
    mv /wg++/startup.sh /etc/my_init.d/


VOLUME /config \
       /data


