#!/bin/bash
echo Welcome to Pi-Utils setup.

SETUPNETWORK="n"
SETUPTTS="n"

## Run setup without asking questions
if [ "$1" == "automated" ]
then
	SETUPNETWORK="y"
	SETUPTTS="y"
fi

####
## NETWORKING
####

## Prompt for network setup
if [ "$SETUPNETWORK" == "n" ]
then
	read -p 'Would you like to configure network tools? [Y/n] ' SETUPNETWORK
	SETUPNETWORK=$(echo "$SETUPNETWORK" | tr '[:upper:]' '[:lower:]')
fi

if [ "$SETUPNETWORK" == "y" ]
then
	cd networking
	echo Setting up networking utils.
	sudo ./setup.sh
	cd ..
fi

####
## TTS
####

## Prompt for tts setup
if [ "$SETUPTTS" == "n" ]
then
	read -p 'Would you like to configure text-to-speech tools? [Y/n] ' SETUPTTS
	SETUPTTS=$(echo "$SETUPTTS" | tr '[:upper:]' '[:lower:]')
fi

if [ "$SETUPTTS" == "y" ]
then
	cd tts
	echo Setting up speech utils.
	sudo ./setup.sh
	cd ..
fi

sudo reboot
