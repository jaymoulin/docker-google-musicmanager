FROM python:alpine3.6 as builder

COPY qemu-*-static /usr/bin/

FROM builder

LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <https://twitter.com/MoulinJay>"

ENV REMOVE=0
ENV UPLOADER_ID=false
ENV ONESHOT=0
ENV DOWNLOAD=true
ENV UPLOAD=true

RUN apk update && \
    apk add linux-headers g++ libxslt-dev libxml2-dev --no-cache --virtual .build-deps && \
    apk add ffmpeg && mkdir /root/oauth/ && \
    pip3 install --upgrade pip && \
    pip3 install google-music-manager-uploader google-music-manager-downloader && \
    apk del g++ --purge .build-deps

COPY ./daemon.sh /root/daemon
COPY ./auth.sh /root/auth

VOLUME /media/library/upload
VOLUME /media/library/download
VOLUME /root/oauth

WORKDIR /root
ENV PATH="/root:${PATH}"
CMD ["daemon"]
