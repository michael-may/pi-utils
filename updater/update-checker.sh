#!/bin/bash

if [ ! -d ~/app ]
then
	echo 'Application not installed. Quitting.'
	exit
fi

cd ~/app

if [ ! -f ~/app/.version ]
then
	echo 'Application .version file is missing. Quitting.'
	exit
fi

LOCALVERSION="$(cat .version)"
echo "Local version is $LOCALVERSION"

git fetch origin
git checkout origin/master -- .version

SERVERVERSION="$(cat .version)"
echo "Remote version is $SERVERVERSION"

if [ "$LOCALVERSION" == "$SERVERVERSION" ]
then
	echo "Up to date!"
	exit
fi

echo "Running update script"
chmod +x update.sh
./update.sh

sudo reboot