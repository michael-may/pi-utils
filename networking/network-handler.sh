#!/bin/bash

CHECKS=0
CONNECTED=false

while [ $CONNECTED != true ] && [ $CHECKS -lt 10 ]; do
	echo 'checking connectivity';
	sleep 5;
	[[ $(./connectivity-checker.sh) =~ "network_connected" ]] && CONNECTED=true;
	CHECKS=$((CHECKS + 1));
done

if $CONNECTED != false;
then
	echo 'looks to be connected';
	exit;
else
	echo 'need to configure';
	sudo ./start-ap.sh
fi
