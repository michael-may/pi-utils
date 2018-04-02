#!/bin/bash
echo Removing networking toolset.
sudo apt-get remove -y hostapd dnsmasq nodejs
sudo apt-get autoremove -y

sudo rm -rf /etc/hostapd/*
sudo rmdir /etc/hostapd

sudo rm -rf /etc/default/hostapd

sudo rm -rf /etc/dnsmasq.conf

sed -i '/##NETWORKCHECKER/,/##NETWORKCHECKER/d' ~/.bashrc

echo Done.
