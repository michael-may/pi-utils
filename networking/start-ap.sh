#!/bin/bash
echo Starting configuration access point...
sudo systemctl stop networking
sudo rm -rf /etc/wpa_supplicant/wpa_supplicant.conf
sudo systemctl start networking

sudo ifconfig wlan0 192.168.66.1 netmask 255.255.255.0
sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'

sudo iptables --flush
sudo iptables -t nat --flush
sudo iptables -t nat -A PREROUTING -i wlan0 -p udp -m udp --dport 53 -j DNAT --to-destination 192.168.66.1:53
sudo iptables -t nat -A PREROUTING -i wlan0 -p tcp -m tcp --dport 80 -j DNAT --to-destination 192.168.66.1:80
sudo iptables -t nat -A PREROUTING -i wlan0 -p tcp -m tcp --dport 443 -j DNAT --to-destination 192.168.66.1:80
sudo iptables -t nat -A POSTROUTING -j MASQUERADE

#sudo iptables -t nat -A PREROUTING -d 0/0 -p tcp --dport 80 -j DNAT --to-destination 192.168.66.1:80

sudo service hostapd start
sudo service dnsmasq start

cd server && sudo node ./server/server.js &

echo Done.
exit
