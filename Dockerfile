FROM alpine:3.17.2 AS build 
RUN apk -U --no-cache add \
	git \
	build-base \
        avahi-dev \
	autoconf \
	automake \
	libtool \
	libdaemon-dev \
	alsa-lib-dev \
	libressl-dev \
	libconfig-dev \
	libstdc++ \
	gcc \
	rust \
	rustup \
	cargo 

RUN cd /root \ 
&& git clone https://github.com/Spotifyd/spotifyd . \
&& git checkout tags/v0.3.4 \
&& cargo build --release
FROM alpine:3.17.2
RUN apk -U --no-cache add \
        libtool \
        libconfig-dev \
	alsa-lib \
	avahi \
	dbus
COPY --from=build /root/target/release/spotifyd /usr/bin/spotifyd
ADD start.sh /
RUN chmod +x /start.sh
CMD [ "sh","/start.sh" ]
