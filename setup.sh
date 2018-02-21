#!/bin/bash
echo Configuring pi-tools.

cd networking
echo Setting up networking utils.
sudo ./setup.sh
cd ..

cd tts
echo Setting up speech utils.
sudo ./setup.sh
cd ..

sudo reboot
