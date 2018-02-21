#!/bin/bash

CHECKS=0
CONNECTED=false

while [ $CONNECTED != true ] && [ $CHECKS -lt 10 ]; do
	echo 'Checking network connectivity...';
	sleep 5;
	[[ $(./connectivity-checker.sh) =~ "network_connected" ]] && CONNECTED=true;
	CHECKS=$((CHECKS + 1));
done

if $CONNECTED != false;
then
	echo 'Looks good.';
	exit;
else
	echo 'Not connected, launching connection configuration...';
	sudo ./start-ap.sh
fi
