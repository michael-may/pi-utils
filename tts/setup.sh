#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get install -y alsa-utils libttspico-utils mplayer

grep -q -F 'snd_bcm2835' /etc/modules || sudo echo 'snd_bcm2835' >> /etc/modules
grep -q -F 'nolirc=yes' /etc/mplayer/mplayer.conf || sudo echo 'nolirc=yes' >> /etc/mplayer/mplayer.conf

ln -s /dev/stdout /var/local/pico2wavebuffer.wav
ln -s "$DIR/say.sh" /usr/local/bin/say
