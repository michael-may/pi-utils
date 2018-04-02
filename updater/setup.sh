#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo Installing dependencies.
#sudo apt-get install -y git
echo Done.

read -p 'Please enter the git URL for your application: ' REPOURL

git clone $REPOURL ~/app

if grep -q -F "##UPDATER" ~/.bashrc
then
	echo "Update daemon already installed."
	exit
else
	echo "Installing update daemon."
fi

echo "Linking update checker to /usr/local/bin."
ln -s "$DIR/update-checker.sh" /usr/local/bin/update-checker
echo "Done."

echo "Adding startup script."
## This could be on an interval with "watch -n SECONDS update-checker"
cat >> ~/.bashrc <<EOF
##UPDATER
update-checker
##UPDATER
EOF
echo "Done."