#!/bin/bash
sed -i '/##UPDATER/,/##UPDATER/d' ~/.bashrc

rm -rf /usr/local/bin/update-checker