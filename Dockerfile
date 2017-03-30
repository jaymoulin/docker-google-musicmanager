FROM sdhibit/rpi-raspbian

MAINTAINER Jay MOULIN <jaymoulin@gmail.com>

RUN apt-get update && apt-get install python3-pip libav-tools build-essential -y && mkdir /root/oauth/ && \
    pip3 install watchdog gmusicapi bs4 && apt-get clean && apt-get autoremove -y

ADD ./daemon.sh /root/daemon.sh
ADD ./google-music-manager/upload-daemon.py /root/upload.py
ADD ./google-music-manager/download.py /root/download.py
ADD ./google-music-manager/auth.py /root/auth.py
ADD ./auth.sh /root/auth
RUN chmod +x /root/upload.py
RUN chmod +x /root/download.py
RUN chmod +x /root/daemon.sh
RUN chmod +x /root/auth.py

VOLUME /media/library
VOLUME /root/oauth

WORKDIR /root
CMD ["/root/daemon.sh"]
