FROM jaymoulin/rpi-python:alpine 

MAINTAINER Jay MOULIN <jaymoulin@gmail.com>

RUN apk update && \
	apk add git linux-headers g++ --no-cache --virtual .build-deps && \
	git clone https://github.com/jaymoulin/google-music-manager.git /root/manager && \
	apk add ffmpeg && mkdir /root/oauth/ && \
    pip3 install watchdog gmusicapi bs4 netifaces && \
	apk del git --purge .build-deps

ADD ./daemon.sh /root/daemon.sh
ADD ./auth.sh /root/auth
RUN chmod +x /root/manager/uploader-daemon.py
RUN chmod +x /root/manager/download.py
RUN chmod +x /root/daemon.sh
RUN chmod +x /root/manager/auth.py

VOLUME /media/library/upload
VOLUME /media/library/download
VOLUME /root/oauth

WORKDIR /root
ENV PATH="/root:${PATH}"
CMD ["/root/daemon.sh"]
