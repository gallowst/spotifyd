FROM alpine:3.18.2 AS build
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
		cargo \
		&& cd /root \
		&& git clone https://github.com/Spotifyd/spotifyd . \
		&& git checkout tags/v0.3.5 \
		&& cargo build --release \
		&& apk del build-base rust rustup cargo

FROM alpine:3.18.2
RUN apk -U --no-cache add \
		libtool \
		libconfig-dev \
		avahi \
		dbus \
		alsa-utils \
		alsa-utils-doc \
		alsa-lib \
		alsaconf \
		alsa-ucm-conf \
		pulseaudio \
		pulseaudio-alsa \
		pulsemixer \
		&& addgroup -S spotifyd \
		&& adduser -S -G spotifyd spotifyd
COPY --from=build /root/target/release/spotifyd /usr/bin/spotifyd
ADD start.sh /
RUN chmod +x /start.sh
#USER spotifyd
CMD [ "sh","/start.sh" ]
