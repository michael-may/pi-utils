#!/bin/bash

echo Reverting TTS utils.

sudo apt-get remove alsa-utils
sudo apt-get remove mplayer
sudo apt-get remove libttspico-utils

sudo apt-get autoremove -y

sudo rm /var/local/pico2wavebuffer.wav
sudo rm /usr/local/bin/say
sudo sed -i '/nolirc=yes/d' /etc/mplayer/mplayer.conf
sudo sed -i '/snd_bcm2835/d' /etc/modules

echo Done.
