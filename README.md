# Spotifyd Docker Image based on Alpine Linux

[![Build Status](https://dev.azure.com/gallowst/docker/_apis/build/status/gallowst.spotifyd?branchName=main)](https://dev.azure.com/gallowst/docker/_build/latest?definitionId=29&branchName=main)

 - Heavily based on [this](https://hub.docker.com/r/rohmilkaese/spotifyd) docker image but as that hadn't been updated for a while I decided to copy the code and roll my own container
 - Enables the abiity to run `spotifyd` in a lightweight container and stream spotify to the speaker attached to the Docker host 
- [Spotifyd](https://github.com/Spotifyd/spotifyd) supports the Spotify Connect protocol, which makes it show up as a device that can be controlled from the official clients.

## Docker Command Line

~~~bash
docker run -it --rm --device /dev/snd -v $(pwd)/spotifyd.conf:/etc/spotifyd.conf gallows/spotifyd:0.3.4
~~~

- Assumes that there is a valid spotifyd.conf file in the current working directory

## Docker Compose

~~~yaml
version: "2.2"
services:
   spotifyd:
    container_name: spotifyd
    image: gallows/spotifyd:latest
    volumes:
       - ./conf/spotifyd.conf:/etc/spotifyd.conf:ro
    devices:
       - /dev/snd
~~~

## Spodifyd Config File

~~~bash
username = ""
password = ""
backend = "alsa"
device = "sysdefault:CARD=PCH"
control = "sysdefault:CARD=PCH"
mixer = "PCM"
volume_controller = "alsa"
bitrate = 320
no_audio_cache = true
initial_volume = "20"
volume_normalisation = true
normalisation_pregain = -10
device_type = "speaker"
~~~
