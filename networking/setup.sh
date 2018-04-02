#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo Installing dependencies.
sudo apt-get install -y hostapd dnsmasq

echo Done.
echo Writing default hostapd config.
sudo cat > /etc/hostapd/hostapd.conf <<EOF

# Interface to use
interface=wlan0

# Driver
driver=nl80211

# The SSID for your connection network
ssid=musicbox-connector

# WiFi channel to use
channel=6

# IEEE mode to use: a/b/g/n, etc.
hw_mode=g
ieee80211n=1          # 802.11n support
wmm_enabled=1         # QoS support
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
auth_algs=1
wmm_enabled=0

# Device name
# User-friendly description of device; up to 32 octets encoded in UTF-8
#device_name=Music Box
# Company name
manufacturer=Ivan | Michael
# Manufacturer
# The manufacturer of the device (up to 64 ASCII characters)
#manufacturer=Company
# Model Name
# Model of the device (up to 32 ASCII characters)
#model_name=WAP
# Model Number
# Additional device description (up to 32 ASCII characters)
#model_number=123
# Serial Number
# Serial number of the device (up to 32 characters)
#serial_number=12345

EOF
sudo cat > /etc/default/hostapd <<EOF
DAEMON_CONF="/etc/hostapd/hostapd.conf"
EOF
echo Done.
echo Writing default dnsmasq config.
sudo cat > /etc/dnsmasq.conf <<EOF
# Never forward addresses in the non-routed address spaces.
bogus-priv
#　Add other name servers here, with domain specs if they are for　non-public domains.
server=/localnet/192.168.66.1
# Add local-only domains here, queries in these domains are answered　from /etc/hosts or DHCP only.
local=/localnet/
# Make all host names resolve to the Raspberry Pi's IP address
address=/#/192.168.66.1
# Specify the interface that will listen for DHCP and DNS requests
interface=wlan0
# Set the domain for dnsmasq
domain=localnet
# Specify the range of IP addresses the DHCP server will lease out to devices, and the duration of the lease
dhcp-range=192.168.66.10,192.168.66.254,1h
# Specify the default route
dhcp-option=3,192.168.66.1
# Specify the DNS server address
dhcp-option=6,192.168.66.1
# Set the DHCP server to authoritative mode.
dhcp-authoritative
EOF
echo Done.

if grep -q -F "##NETWORKCHECKER" ~/.bashrc
then
	echo "Network checker daemon already installed."
else
	echo "Installing network checker daemon."
cat >> ~/.bashrc <<EOF
##NETWORKCHECKER
cd $DIR && sudo ./network-handler.sh && cd ~
##NETWORKCHECKER
EOF
fi

echo Configuring Nodejs.
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

cd server && npm i && cd ..
echo Done.
