#!/bin/bash
#rm -rf /var/run
#mkdir -p /var/run/dbus
#dbus-uuidgen --ensure
#dbus-daemon --system
#avahi-daemon --daemonize --no-chroot
#pulseaudio --start
/usr/bin/spotifyd --config-path /etc/spotifyd.conf --no-daemon
