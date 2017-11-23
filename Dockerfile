FROM python:alpine3.6 as builder

COPY qemu-*-static /usr/bin/

FROM builder

LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <https://twitter.com/MoulinJay>"

ENV REMOVE=1
ENV UPLOADER_ID=false

RUN apk update && \
    apk add linux-headers g++ --no-cache --virtual .build-deps && \
    apk add ffmpeg && mkdir /root/oauth/ && \
    pip3 install MechanicalSoup==0.8.0 google-music-manager-uploader google-music-manager-downloader && \
    apk del g++ --purge .build-deps

ADD ./daemon.sh /root/daemon

VOLUME /media/library/upload
VOLUME /media/library/download
VOLUME /root/oauth

WORKDIR /root
ENV PATH="/root:${PATH}"
CMD ["daemon"]
