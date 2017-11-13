FROM jaymoulin/rpi-python:alpine 

MAINTAINER Jay MOULIN <jaymoulin@gmail.com>

RUN apk update && \
	apk add linux-headers g++ --no-cache --virtual .build-deps && \
	apk add ffmpeg && mkdir /root/oauth/ && \
    pip3 install MechanicalSoup==0.8.0 google-music-manager-uploader google-music-manager-downloader && \
	apk del g++ --purge .build-deps

ADD ./daemon.sh /root/daemon.sh
RUN chmod +x /root/daemon.sh

VOLUME /media/library/upload
VOLUME /media/library/download
VOLUME /root/oauth

WORKDIR /root
ENV PATH="/root:${PATH}"
CMD ["/root/daemon.sh"]
