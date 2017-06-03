![logo](logo.png)

Raspberry PI - Google Music Manager - Docker Image
==================================================

[![latest release](https://img.shields.io/github/release/jaymoulin/docker-rpi-google-musicmanager.svg "latest release")](http://github.com/jaymoulin/docker-rpi-google-musicmanager/releases)

This image allows you to download and upload your Google Music Library to/from a selected folder.
This image is based on [Google MusicManager](https://github.com/jaymoulin/google-music-manager)

Installation
---

```
docker run -d --restart=always -v /path/to/your/upload/library:/media/library/upload -v /path/to/your/download/library:/media/library/download --name googlemusicmanager jaymoulin/rpi-google-musicmanager
```

You must define your path to your upload library in a volume to `/media/library/upload`
You must define your path to your download library in a volume to `/media/library/download`

You can also mount a folder to `/root/oauth` to keep or reuse your key

Configuration
---
First, you have to allow the container to access your Google Music account
```
docker exec -ti googlemusicmanager auth
```
Then follow prompted instructions.

You will be asked to go to a Google URL to allow the connection:

```
Visit the following url:
 https://accounts.google.com/o/oauth2/v2/auth?client_id=XXXXXXXXXXX.apps.googleusercontent.com&access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fmusicmanager&response_type=code&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob
Follow the prompts, then paste the auth code here and hit enter:
```

Once done, restart the container to start downloading your library
```
docker restart googlemusicmanager
```

Appendixes
---

### Install RaspberryPi Docker

If you don't have Docker installed yet, you can do it easily in one line using this command
 
```
curl -sSL "https://gist.githubusercontent.com/jaymoulin/e749a189511cd965f45919f2f99e45f3/raw/054ba73080c49a0fcdbc6932e27887a31c7abce2/ARM%2520(Raspberry%2520PI)%2520Docker%2520Install" | sudo sh && sudo usermod -aG docker $USER
```

### Build Docker Image

To build this image locally - use given `build.sh` to be able to use dependencies 

```
./build.sh
```
