#!/bin/bash

OUTPUT=$1

if [ -z "$OUTPUT" ]
then
	OUTPUT="I've got nothing to say."
fi

pico2wave -w /var/local/pico2wavebuffer.wav "$OUTPUT" | aplay
