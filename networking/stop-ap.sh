echo Disabling configuration access point...
sudo ifconfig wlan0 0.0.0.0

sudo iptables -F

#sudo systemctl disable dnsmasq
sudo service dnsmasq stop
sudo service hostapd stop

echo Done.
exit
