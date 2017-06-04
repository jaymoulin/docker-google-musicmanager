FROM jaymoulin/rpi-python:alpine 

MAINTAINER Jay MOULIN <jaymoulin@gmail.com>

RUN apk update && apk add ffmpeg g++ && mkdir /root/oauth/ && \
    pip3 install watchdog gmusicapi bs4

ADD ./daemon.sh /root/daemon.sh
ADD ./google-music-manager/uploader-daemon.py /root/upload.py
ADD ./google-music-manager/download.py /root/download.py
ADD ./google-music-manager/auth.py /root/auth.py
ADD ./auth.sh /root/auth
RUN chmod +x /root/upload.py
RUN chmod +x /root/download.py
RUN chmod +x /root/daemon.sh
RUN chmod +x /root/auth.py

VOLUME /media/library/upload
VOLUME /media/library/download
VOLUME /root/oauth

WORKDIR /root
ENV PATH="/root:${PATH}"
CMD ["/root/daemon.sh"]
